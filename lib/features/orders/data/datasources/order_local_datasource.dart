import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/entities/order_item.dart';

abstract class OrderLocalDataSource {
  Future<List<CustomerOrder>> getOrders();
  Future<CustomerOrder> createOrder(CustomerOrder order);
  Future<void> updateOrderStatus(String orderId, OrderExecutionStatus newStatus);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final AppDatabase database;

  OrderLocalDataSourceImpl(this.database);

  @override
  Future<List<CustomerOrder>> getOrders() async {
    // 1. Join customer_orders with customers table to retrieve customer names
    final query = database.select(database.customerOrdersTable).join([
      innerJoin(
        database.customersTable,
        database.customersTable.id.equalsExp(database.customerOrdersTable.customerId),
      ),
    ]);

    query.orderBy([
      OrderingTerm(expression: database.customerOrdersTable.createdAt, mode: OrderingMode.desc),
    ]);

    final rows = await query.get();

    final orders = <CustomerOrder>[];

    for (final row in rows) {
      final orderRow = row.readTable(database.customerOrdersTable);
      final customerRow = row.readTable(database.customersTable);

      // 2. Fetch items for this order
      final itemRows = await (database.select(database.orderItemsTable)
            ..where((t) => t.orderId.equals(orderRow.id)))
          .get();

      final currency = Currency.fromCode(orderRow.currencyCode);

      final items = itemRows.map((i) {
        return OrderItem(
          id: i.id,
          orderId: i.orderId,
          productId: i.productId,
          title: i.title,
          imagePath: i.imagePath,
          color: i.color,
          size: i.size,
          notes: i.notes,
          quantity: i.quantity,
          saleUnitPrice: Money(amountMinor: i.saleUnitPriceMinor, currency: currency),
          unitCost: i.unitCostMinor != null
              ? Money(amountMinor: i.unitCostMinor!, currency: currency)
              : null,
          allocatedExtraCost: i.allocatedExtraCostMinor != null
              ? Money(amountMinor: i.allocatedExtraCostMinor!, currency: currency)
              : null,
        );
      }).toList();

      orders.add(
        CustomerOrder(
          id: orderRow.id,
          customerId: orderRow.customerId,
          customerName: customerRow.name,
          orderNumber: orderRow.orderNumber,
          executionStatus: _parseExecutionStatus(orderRow.executionStatus),
          paymentStatus: _parsePaymentStatus(orderRow.paymentStatus),
          currency: currency,
          items: items,
          paidAmount: Money(amountMinor: orderRow.paidAmountMinor, currency: currency),
          discountAmount: Money(amountMinor: orderRow.discountAmountMinor, currency: currency),
          notes: orderRow.notes,
          createdAt: orderRow.createdAt,
          updatedAt: orderRow.updatedAt,
        ),
      );
    }

    return orders;
  }

  @override
  Future<CustomerOrder> createOrder(CustomerOrder order) async {
    // Atomic transaction: insert order and its items together
    await database.transaction(() async {
      await database.into(database.customerOrdersTable).insert(
            CustomerOrdersTableCompanion.insert(
              id: order.id,
              customerId: order.customerId,
              orderNumber: order.orderNumber,
              executionStatus: order.executionStatus.name,
              paymentStatus: order.paymentStatus.name,
              currencyCode: order.currency.code,
              paidAmountMinor: Value(order.paidAmount.amountMinor),
              discountAmountMinor: Value(order.discountAmount.amountMinor),
              notes: Value(order.notes),
              createdAt: Value(order.createdAt),
              updatedAt: Value(order.updatedAt),
            ),
          );

      for (final item in order.items) {
        await database.into(database.orderItemsTable).insert(
              OrderItemsTableCompanion.insert(
                id: item.id,
                orderId: order.id,
                productId: Value(item.productId),
                title: item.title,
                imagePath: Value(item.imagePath),
                color: Value(item.color),
                size: Value(item.size),
                notes: Value(item.notes),
                quantity: Value(item.quantity),
                saleUnitPriceMinor: item.saleUnitPrice.amountMinor,
                unitCostMinor: Value(item.unitCost?.amountMinor),
                allocatedExtraCostMinor: Value(item.allocatedExtraCost?.amountMinor),
              ),
            );
      }
    });

    return order;
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderExecutionStatus newStatus) async {
    await (database.update(database.customerOrdersTable)..where((t) => t.id.equals(orderId))).write(
      CustomerOrdersTableCompanion(
        executionStatus: Value(newStatus.name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  OrderExecutionStatus _parseExecutionStatus(String status) {
    return OrderExecutionStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => OrderExecutionStatus.newOrder,
    );
  }

  OrderPaymentStatus _parsePaymentStatus(String status) {
    return OrderPaymentStatus.values.firstWhere(
      (p) => p.name == status,
      orElse: () => OrderPaymentStatus.unpaid,
    );
  }
}
