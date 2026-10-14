import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/features/customers/data/datasources/customer_local_datasource.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';
import 'package:storee/features/orders/data/datasources/order_local_datasource.dart';
import 'package:storee/features/orders/data/repositories/order_repository_impl.dart';
import 'package:storee/features/orders/domain/entities/customer_order.dart';
import 'package:storee/features/orders/domain/entities/order_item.dart';

void main() {
  late AppDatabase db;
  late CustomerLocalDataSource customerDataSource;
  late OrderLocalDataSource orderDataSource;
  late OrderRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.inMemory();
    customerDataSource = CustomerLocalDataSourceImpl(db);
    orderDataSource = OrderLocalDataSourceImpl(db);
    repository = OrderRepositoryImpl(orderDataSource);

    // Pre-insert customer
    await customerDataSource.addCustomer(
      Customer(
        id: 'cust-test',
        name: 'فاطمة الكاف',
        phone: '777123456',
        defaultCurrency: Currency.sar,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('OrderRepository Tests', () {
    test('creates order with items and retrieves it with correct calculated amounts', () async {
      final order = CustomerOrder(
        id: 'ord-test-1',
        customerId: 'cust-test',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1055',
        executionStatus: OrderExecutionStatus.newOrder,
        paymentStatus: OrderPaymentStatus.unpaid,
        currency: Currency.sar,
        items: [
          OrderItem(
            id: 'item-1',
            orderId: 'ord-test-1',
            title: 'فستان مخمل مطرز',
            quantity: 2,
            saleUnitPrice: Money.fromMajor(120, Currency.sar),
          ),
          OrderItem(
            id: 'item-2',
            orderId: 'ord-test-1',
            title: 'حقيبة كلاسيكية',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(80, Currency.sar),
          ),
        ],
        paidAmount: Money.zero(Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createResult = await repository.createOrder(order);
      expect(createResult.isRight(), true);

      final listResult = await repository.getOrders();
      expect(listResult.isRight(), true);

      listResult.fold(
        (_) => fail('Expected right'),
        (orders) {
          expect(orders.length, 1);
          final savedOrder = orders.first;
          expect(savedOrder.orderNumber, '#1055');
          expect(savedOrder.customerName, 'فاطمة الكاف');
          expect(savedOrder.items.length, 2);
          // 2x 120 SAR + 1x 80 SAR = 320 SAR
          expect(savedOrder.totalAmount.toMajor, 320.0);
          expect(savedOrder.totalAmount.amountMinor, 32000);
          expect(savedOrder.remainingAmount.toMajor, 320.0);
        },
      );
    });

    test('updates order execution status in SQLite successfully', () async {
      final order = CustomerOrder(
        id: 'ord-status-test',
        customerId: 'cust-test',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1056',
        executionStatus: OrderExecutionStatus.newOrder,
        paymentStatus: OrderPaymentStatus.unpaid,
        currency: Currency.sar,
        items: const [],
        paidAmount: Money.zero(Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repository.createOrder(order);

      final updateResult = await repository.updateOrderStatus(
        'ord-status-test',
        OrderExecutionStatus.readyToDeliver,
      );
      expect(updateResult.isRight(), true);

      final listResult = await repository.getOrders();
      listResult.fold(
        (_) => fail('Expected right'),
        (orders) {
          expect(orders.first.executionStatus, OrderExecutionStatus.readyToDeliver);
        },
      );
    });

    test('persists item imagePath and notes in SQLite and formats specsDescription', () async {
      final order = CustomerOrder(
        id: 'ord-photo-test',
        customerId: 'cust-test',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1057',
        executionStatus: OrderExecutionStatus.newOrder,
        paymentStatus: OrderPaymentStatus.unpaid,
        currency: Currency.sar,
        items: [
          OrderItem(
            id: 'item-photo-1',
            orderId: 'ord-photo-test',
            title: 'فستان شيفون تركي',
            imagePath: '/data/user/0/com.storee.app/cache/photo_1.jpg',
            size: 'L',
            color: 'وردي',
            notes: 'خامة شيفون مع بطانة حرير',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(150, Currency.sar),
          ),
        ],
        paidAmount: Money.zero(Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final res = await repository.createOrder(order);
      expect(res.isRight(), true);

      final listResult = await repository.getOrders();
      listResult.fold(
        (_) => fail('Expected orders'),
        (orders) {
          final found = orders.firstWhere((o) => o.id == 'ord-photo-test');
          final item = found.items.first;
          expect(item.imagePath, '/data/user/0/com.storee.app/cache/photo_1.jpg');
          expect(item.size, 'L');
          expect(item.color, 'وردي');
          expect(item.notes, 'خامة شيفون مع بطانة حرير');
          expect(item.hasOptionalDetails, true);
          expect(item.specsDescription, 'اللون: وردي • المقاس: L • خامة شيفون مع بطانة حرير');
        },
      );
    });
  });
}
