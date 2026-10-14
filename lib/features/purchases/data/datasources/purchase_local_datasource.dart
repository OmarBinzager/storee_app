import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../../domain/entities/purchase_batch.dart';

abstract class PurchaseLocalDataSource {
  Future<List<PurchaseBatch>> getBatches();
  Future<List<OrderItem>> getUnassignedOrderItems();
  Future<PurchaseBatch> createBatch({
    required String storeName,
    String? invoiceReference,
    required Currency currency,
    required Money extraCosts,
    required Money discounts,
    required List<BatchItemAllocated> items,
    String? payingWalletId,
    DateTime? purchasedAt,
  });
  Future<void> updateBatchStatus(String batchId, PurchaseBatchStatus newStatus);
}

class PurchaseLocalDataSourceImpl implements PurchaseLocalDataSource {
  final AppDatabase database;

  PurchaseLocalDataSourceImpl(this.database);

  @override
  Future<List<PurchaseBatch>> getBatches() async {
    final batchRows = await (database.select(database.purchaseBatchesTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.purchasedAt, mode: OrderingMode.desc),
          ]))
        .get();

    final batches = <PurchaseBatch>[];

    for (final b in batchRows) {
      final currency = Currency.fromCode(b.currencyCode);

      final itemRows = await (database.select(database.purchaseBatchItemsTable)
            ..where((t) => t.batchId.equals(b.id)))
          .get();

      final allocatedItems = <BatchItemAllocated>[];
      for (final i in itemRows) {
        // Fetch order item title
        final orderItemRow = await (database.select(database.orderItemsTable)
              ..where((t) => t.id.equals(i.orderItemId)))
            .getSingleOrNull();

        allocatedItems.add(
          BatchItemAllocated(
            orderItemId: i.orderItemId,
            title: orderItemRow?.title ?? 'منتج',
            quantity: i.quantity,
            baseCost: Money(amountMinor: i.unitCostMinor, currency: currency),
            allocatedExtraCost: Money(amountMinor: i.allocatedExtraCostMinor, currency: currency),
            manualOverrideReason: i.manualOverrideReason,
          ),
        );
      }

      batches.add(
        PurchaseBatch(
          id: b.id,
          storeName: b.storeName,
          invoiceReference: b.invoiceReference,
          currency: currency,
          extraCosts: Money(amountMinor: b.extraCostsMinor, currency: currency),
          discounts: Money(amountMinor: b.discountsMinor, currency: currency),
          items: allocatedItems,
          purchasedAt: b.purchasedAt,
          status: _parseBatchStatus(b.status),
        ),
      );
    }

    return batches;
  }

  @override
  Future<List<OrderItem>> getUnassignedOrderItems() async {
    // Unassigned items are those where unitCostMinor IS NULL
    final rows = await (database.select(database.orderItemsTable)
          ..where((t) => t.unitCostMinor.isNull()))
        .get();

    final items = <OrderItem>[];
    for (final r in rows) {
      // Find order currency
      final orderRow = await (database.select(database.customerOrdersTable)
            ..where((t) => t.id.equals(r.orderId)))
          .getSingleOrNull();

      final currency = Currency.fromCode(orderRow?.currencyCode ?? 'SAR');

      items.add(
        OrderItem(
          id: r.id,
          orderId: r.orderId,
          productId: r.productId,
          title: r.title,
          imagePath: r.imagePath,
          color: r.color,
          size: r.size,
          notes: r.notes,
          quantity: r.quantity,
          saleUnitPrice: Money(amountMinor: r.saleUnitPriceMinor, currency: currency),
        ),
      );
    }

    return items;
  }

  @override
  Future<PurchaseBatch> createBatch({
    required String storeName,
    String? invoiceReference,
    required Currency currency,
    required Money extraCosts,
    required Money discounts,
    required List<BatchItemAllocated> items,
    String? payingWalletId,
    DateTime? purchasedAt,
  }) async {
    final batchId = const Uuid().v4();
    final now = DateTime.now();
    final effectivePurchasedAt = purchasedAt ?? now;

    final batch = PurchaseBatch(
      id: batchId,
      storeName: storeName,
      invoiceReference: invoiceReference,
      currency: currency,
      extraCosts: extraCosts,
      discounts: discounts,
      items: items,
      purchasedAt: effectivePurchasedAt,
      status: PurchaseBatchStatus.purchased,
    );

    await database.transaction(() async {
      // 1. Insert purchase batch record
      await database.into(database.purchaseBatchesTable).insert(
            PurchaseBatchesTableCompanion.insert(
              id: batchId,
              storeName: storeName,
              invoiceReference: Value(invoiceReference),
              currencyCode: currency.code,
              extraCostsMinor: Value(extraCosts.amountMinor),
              discountsMinor: Value(discounts.amountMinor),
              status: PurchaseBatchStatus.purchased.name,
              purchasedAt: effectivePurchasedAt,
              createdAt: Value(now),
            ),
          );

      // 2. Insert items and update corresponding order items' unit cost
      for (final item in items) {
        await database.into(database.purchaseBatchItemsTable).insert(
              PurchaseBatchItemsTableCompanion.insert(
                id: const Uuid().v4(),
                batchId: batchId,
                orderItemId: item.orderItemId,
                quantity: item.quantity,
                unitCostMinor: item.baseCost.amountMinor,
                allocatedExtraCostMinor: Value(item.allocatedExtraCost.amountMinor),
                manualOverrideReason: Value(item.manualOverrideReason),
              ),
            );

        // Update the order item itself in SQLite
        await (database.update(database.orderItemsTable)..where((t) => t.id.equals(item.orderItemId)))
            .write(
          OrderItemsTableCompanion(
            unitCostMinor: Value(item.baseCost.amountMinor),
            allocatedExtraCostMinor: Value(item.allocatedExtraCost.amountMinor),
          ),
        );

        // Check if all items in this order are now purchased
        final orderItem = await (database.select(database.orderItemsTable)
              ..where((t) => t.id.equals(item.orderItemId)))
            .getSingle();

        final remainingUnassigned = await (database.select(database.orderItemsTable)
              ..where((t) => t.orderId.equals(orderItem.orderId) & t.unitCostMinor.isNull()))
            .get();

        if (remainingUnassigned.isEmpty) {
          await (database.update(database.customerOrdersTable)
                ..where((t) => t.id.equals(orderItem.orderId)))
              .write(
            CustomerOrdersTableCompanion(
              executionStatus: Value(OrderExecutionStatus.purchased.name),
              updatedAt: Value(now),
            ),
          );
        }
      }

      // 3. Deduct from paying wallet if provided
      if (payingWalletId != null) {
        final totalPaymentMinor = batch.finalTotalCost.amountMinor;

        // Deduct from wallet balance
        final balanceRow = await (database.select(database.walletBalancesTable)
              ..where((t) => t.walletId.equals(payingWalletId) & t.currencyCode.equals(currency.code)))
            .getSingleOrNull();

        if (balanceRow != null) {
          await (database.update(database.walletBalancesTable)
                ..where((t) => t.walletId.equals(payingWalletId) & t.currencyCode.equals(currency.code)))
              .write(
            WalletBalancesTableCompanion(
              balanceMinor: Value(balanceRow.balanceMinor - totalPaymentMinor),
            ),
          );
        } else {
          await database.into(database.walletBalancesTable).insert(
                WalletBalancesTableCompanion.insert(
                  walletId: payingWalletId,
                  currencyCode: currency.code,
                  balanceMinor: Value(-totalPaymentMinor),
                ),
              );
        }

        // Record in financial transactions ledger as supplierPayment
        await database.into(database.financialTransactionsTable).insert(
              FinancialTransactionsTableCompanion.insert(
                id: const Uuid().v4(),
                type: 'supplierPayment',
                walletId: payingWalletId,
                amountMinor: totalPaymentMinor,
                currencyCode: currency.code,
                occurredAt: effectivePurchasedAt,
                referenceId: Value(batchId),
                notes: Value('سداد فاتورة شراء جماعي من متجر $storeName'),
                createdAt: Value(now),
              ),
            );
      }
    });

    return batch;
  }

  @override
  Future<void> updateBatchStatus(String batchId, PurchaseBatchStatus newStatus) async {
    final now = DateTime.now();

    await database.transaction(() async {
      // 1. Update purchase batch status
      await (database.update(database.purchaseBatchesTable)..where((t) => t.id.equals(batchId))).write(
        PurchaseBatchesTableCompanion(
          status: Value(newStatus.name),
        ),
      );

      // 2. Find all affected order items
      final batchItemRows = await (database.select(database.purchaseBatchItemsTable)
            ..where((t) => t.batchId.equals(batchId)))
          .get();

      final affectedOrderIds = <String>{};
      for (final bi in batchItemRows) {
        final orderItemRow = await (database.select(database.orderItemsTable)
              ..where((t) => t.id.equals(bi.orderItemId)))
            .getSingleOrNull();
        if (orderItemRow != null) {
          affectedOrderIds.add(orderItemRow.orderId);
        }
      }

      // 3. For each affected order, determine its new execution status
      for (final orderId in affectedOrderIds) {
        final allItemsInOrder = await (database.select(database.orderItemsTable)
              ..where((t) => t.orderId.equals(orderId)))
          .get();

        final orderRow = await (database.select(database.customerOrdersTable)
              ..where((t) => t.id.equals(orderId)))
          .getSingleOrNull();

        if (orderRow == null) continue;

        // Skip orders that are already terminal (delivered or cancelled)
        if (orderRow.executionStatus == OrderExecutionStatus.delivered.name ||
            orderRow.executionStatus == OrderExecutionStatus.cancelled.name) {
          continue;
        }

        // Check the batch status for each item in this order
        var unassignedCount = 0;
        var shippingCount = 0;
        var arrivedCount = 0;

        for (final item in allItemsInOrder) {
          final batchItem = await (database.select(database.purchaseBatchItemsTable)
                ..where((t) => t.orderItemId.equals(item.id)))
              .getSingleOrNull();

          if (batchItem == null) {
            unassignedCount++;
          } else {
            final parentBatch = await (database.select(database.purchaseBatchesTable)
                  ..where((t) => t.id.equals(batchItem.batchId)))
                .getSingleOrNull();

            final batchStatus = parentBatch?.status ?? PurchaseBatchStatus.purchased.name;
            if (batchStatus == PurchaseBatchStatus.arrived.name) {
              arrivedCount++;
            } else if (batchStatus == PurchaseBatchStatus.shipping.name) {
              shippingCount++;
            }
          }
        }

        String determinedStatus;
        if (arrivedCount == allItemsInOrder.length && allItemsInOrder.isNotEmpty) {
          // ALL items have arrived at the boutique! Order is ready for delivery!
          determinedStatus = OrderExecutionStatus.readyToDeliver.name;
        } else if (arrivedCount > 0) {
          // Some items arrived, others still in transit or unassigned
          determinedStatus = OrderExecutionStatus.partiallyArrived.name;
        } else if (shippingCount > 0) {
          // Some or all items in transit
          determinedStatus = OrderExecutionStatus.shipping.name;
        } else if (unassignedCount == 0) {
          // All items purchased
          determinedStatus = OrderExecutionStatus.purchased.name;
        } else {
          determinedStatus = orderRow.executionStatus;
        }

        await (database.update(database.customerOrdersTable)..where((t) => t.id.equals(orderId))).write(
          CustomerOrdersTableCompanion(
            executionStatus: Value(determinedStatus),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  PurchaseBatchStatus _parseBatchStatus(String status) {
    return PurchaseBatchStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => PurchaseBatchStatus.purchased,
    );
  }
}
