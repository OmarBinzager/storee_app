import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/features/customers/data/datasources/customer_local_datasource.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';
import 'package:storee/features/orders/data/datasources/order_local_datasource.dart';
import 'package:storee/features/orders/domain/entities/customer_order.dart';
import 'package:storee/features/orders/domain/entities/order_item.dart';
import 'package:storee/features/purchases/data/datasources/purchase_local_datasource.dart';
import 'package:storee/features/purchases/data/repositories/purchase_repository_impl.dart';
import 'package:storee/features/purchases/domain/services/batch_cost_allocator.dart';
import 'package:storee/features/wallets/data/datasources/wallet_local_datasource.dart';
import 'package:storee/features/wallets/domain/entities/wallet.dart';

void main() {
  late AppDatabase db;
  late CustomerLocalDataSource customerDataSource;
  late OrderLocalDataSource orderDataSource;
  late WalletLocalDataSource walletDataSource;
  late PurchaseLocalDataSource purchaseDataSource;
  late PurchaseRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.inMemory();
    customerDataSource = CustomerLocalDataSourceImpl(db);
    orderDataSource = OrderLocalDataSourceImpl(db);
    walletDataSource = WalletLocalDataSourceImpl(db);
    purchaseDataSource = PurchaseLocalDataSourceImpl(db);
    repository = PurchaseRepositoryImpl(purchaseDataSource);
  });

  tearDown(() async {
    await db.close();
  });

  group('PurchaseRepository Group Purchasing Tests', () {
    test('retrieves unassigned order items and creates purchase batch with proportional allocation and wallet deduction', () async {
      // 1. Setup Customer
      const customerId = 'cust-purch-1';
      final now = DateTime.now();
      await customerDataSource.addCustomer(
        Customer(
          id: customerId,
          name: 'سميرة أحمد',
          phone: '777000111',
          defaultCurrency: Currency.sar,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 2. Setup Order with 2 items (without cost)
      const orderId = 'order-purch-1';
      final orderItem1 = OrderItem(
        id: 'item-1',
        orderId: orderId,
        title: 'فستان مخملي',
        quantity: 1,
        saleUnitPrice: Money.fromMajor(150.0, Currency.sar), // 150 SAR sale price
      );
      final orderItem2 = OrderItem(
        id: 'item-2',
        orderId: orderId,
        title: 'حقيبة يد جلدية',
        quantity: 1,
        saleUnitPrice: Money.fromMajor(250.0, Currency.sar), // 250 SAR sale price
      );

      await orderDataSource.createOrder(
        CustomerOrder(
          id: orderId,
          orderNumber: 'ORD-101',
          customerId: customerId,
          customerName: 'سميرة أحمد',
          executionStatus: OrderExecutionStatus.newOrder,
          paymentStatus: OrderPaymentStatus.unpaid,
          currency: Currency.sar,
          items: [orderItem1, orderItem2],
          paidAmount: Money.zero(Currency.sar),
          discountAmount: Money.zero(Currency.sar),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 3. Verify getUnassignedOrderItems returns both items
      final unassignedResult = await repository.getUnassignedOrderItems();
      expect(unassignedResult.isRight(), true);
      final unassigned = unassignedResult.getOrElse(() => []);
      expect(unassigned.length, 2);

      // 4. Setup Wallet for payment
      final wallet = await walletDataSource.createWallet(
        name: 'بطاقة مدى للتسوق',
        type: WalletType.bankAccount,
      );

      // 5. Allocate shipping and extra costs proportionally
      const allocator = BatchCostAllocator();
      final allocated = allocator.allocate(
        rawItems: [
          (
            orderItemId: 'item-1',
            title: 'فستان مخملي',
            quantity: 1,
            baseCost: Money.fromMajor(100.0, Currency.sar), // 100 SAR purchase base
          ),
          (
            orderItemId: 'item-2',
            title: 'حقيبة يد جلدية',
            quantity: 1,
            baseCost: Money.fromMajor(200.0, Currency.sar), // 200 SAR purchase base
          ),
        ],
        extraCosts: Money.fromMajor(30.0, Currency.sar), // 30 SAR shipping
        discounts: Money.zero(Currency.sar),
      );

      // Total base = 300 SAR. Extra cost = 30 SAR.
      // Item 1 (100 SAR base): 100/300 * 30 = 10 SAR extra
      // Item 2 (200 SAR base): 200/300 * 30 = 20 SAR extra
      expect(allocated[0].allocatedExtraCost, Money.fromMajor(10.0, Currency.sar));
      expect(allocated[1].allocatedExtraCost, Money.fromMajor(20.0, Currency.sar));

      // 6. Create Batch
      final createResult = await repository.createBatch(
        storeName: 'شي إن (SHEIN)',
        invoiceReference: 'SHEIN-INV-9988',
        currency: Currency.sar,
        extraCosts: Money.fromMajor(30.0, Currency.sar),
        discounts: Money.zero(Currency.sar),
        items: allocated,
        payingWalletId: wallet.id,
      );

      expect(createResult.isRight(), true);

      // 7. Verify unassigned items is now empty
      final unassignedAfter = await repository.getUnassignedOrderItems();
      expect(unassignedAfter.getOrElse(() => []).isEmpty, true);

      // 8. Verify order execution status updated to 'purchased'
      final orders = await orderDataSource.getOrders();
      final updatedOrder = orders.firstWhere((o) => o.id == orderId);
      expect(updatedOrder.executionStatus, OrderExecutionStatus.purchased);

      // 9. Verify wallet balance was deducted by total batch cost (300 + 30 = 330 SAR)
      final wallets = await walletDataSource.getWallets();
      final updatedWallet = wallets.firstWhere((w) => w.id == wallet.id);
      expect(updatedWallet.getBalanceFor(Currency.sar).amountMinor, -33000); // minor units: -330.00 SAR

      // 10. Verify getBatches returns our batch
      final batchesResult = await repository.getBatches();
      expect(batchesResult.isRight(), true);
      final batches = batchesResult.getOrElse(() => []);
      expect(batches.length, 1);
      expect(batches.first.storeName, 'شي إن (SHEIN)');
      expect(batches.first.items.length, 2);
      expect(batches.first.finalTotalCost, Money.fromMajor(330.0, Currency.sar));
    });
  });
}
