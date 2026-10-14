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
import 'package:storee/features/purchases/domain/entities/purchase_batch.dart';
import 'package:storee/features/reports/data/datasources/reports_local_datasource.dart';
import 'package:storee/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:storee/features/wallets/data/datasources/wallet_local_datasource.dart';
import 'package:storee/features/wallets/domain/entities/wallet.dart';

void main() {
  late AppDatabase db;
  late CustomerLocalDataSource customerDataSource;
  late OrderLocalDataSource orderDataSource;
  late WalletLocalDataSource walletDataSource;
  late PurchaseLocalDataSource purchaseDataSource;
  late ReportsLocalDataSource reportsDataSource;
  late ReportsRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.inMemory();
    customerDataSource = CustomerLocalDataSourceImpl(db);
    orderDataSource = OrderLocalDataSourceImpl(db);
    walletDataSource = WalletLocalDataSourceImpl(db);
    purchaseDataSource = PurchaseLocalDataSourceImpl(db);
    reportsDataSource = ReportsLocalDataSourceImpl(db);
    repository = ReportsRepositoryImpl(reportsDataSource);
  });

  tearDown(() async {
    await db.close();
  });

  group('ReportsRepository Financial Invariant & Calculations Tests', () {
    test('accurately calculates sales, COGS, allocated shipping, operating expenses, and net profit', () async {
      final now = DateTime.now();

      // 1. Create Customer
      const customerId = 'cust-rep-1';
      await customerDataSource.addCustomer(
        Customer(
          id: customerId,
          name: 'ريم العطاس',
          phone: '777112233',
          defaultCurrency: Currency.sar,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 2. Create Order:
      // Item: Sale price 500 SAR. Paid 300 SAR (remaining 200 SAR debt).
      const orderId = 'ord-rep-1';
      final item = OrderItem(
        id: 'item-rep-1',
        orderId: orderId,
        title: 'طقم عباية فاخرة',
        quantity: 1,
        saleUnitPrice: Money.fromMajor(500.0, Currency.sar),
      );

      await orderDataSource.createOrder(
        CustomerOrder(
          id: orderId,
          customerId: customerId,
          customerName: 'ريم العطاس',
          orderNumber: '#REP-01',
          executionStatus: OrderExecutionStatus.confirmed,
          paymentStatus: OrderPaymentStatus.partial,
          currency: Currency.sar,
          items: [item],
          paidAmount: Money.fromMajor(300.0, Currency.sar),
          discountAmount: Money.zero(Currency.sar),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 3. Purchase Batch for this item:
      // Base purchase cost: 250 SAR. Allocated shipping: 50 SAR. Total cost = 300 SAR.
      await purchaseDataSource.createBatch(
        storeName: 'متجر المصمم',
        currency: Currency.sar,
        extraCosts: Money.fromMajor(50.0, Currency.sar),
        discounts: Money.zero(Currency.sar),
        items: [
          BatchItemAllocated(
            orderItemId: 'item-rep-1',
            title: 'طقم عباية فاخرة',
            quantity: 1,
            baseCost: Money.fromMajor(250.0, Currency.sar),
            allocatedExtraCost: Money.fromMajor(50.0, Currency.sar),
          ),
        ],
      );

      // 4. Setup Wallet & Record Operating Expense and Personal Withdrawal
      final wallet = await walletDataSource.createWallet(
        name: 'خزنة الريال السعودي',
        type: WalletType.cash,
      );

      // Operating expense: 30 SAR (Packaging boxes)
      await walletDataSource.recordExpense(
        walletId: wallet.id,
        amount: Money.fromMajor(30.0, Currency.sar),
        category: 'تغليف',
        notes: 'كراتين شحن أنيقة',
      );

      // Owner Personal Withdrawal: 70 SAR (Should NOT reduce net business profit!)
      await walletDataSource.recordPersonalWithdrawal(
        walletId: wallet.id,
        amount: Money.fromMajor(70.0, Currency.sar),
        notes: 'مصروف شخصي خاص بالمالكة',
      );

      // 5. Fetch Financial Report
      final reportResult = await repository.getFinancialReport(currency: Currency.sar);
      expect(reportResult.isRight(), true);

      final report = reportResult.getOrElse(() => throw Exception());

      // Assertions:
      // Total Sales = 500 SAR
      expect(report.totalSales, Money.fromMajor(500.0, Currency.sar));

      // COGS = 250 SAR
      expect(report.totalCogs, Money.fromMajor(250.0, Currency.sar));

      // Allocated Shipping = 50 SAR
      expect(report.totalAllocatedShipping, Money.fromMajor(50.0, Currency.sar));

      // Gross Profit = 500 - 250 - 50 = 200 SAR
      expect(report.grossProfit, Money.fromMajor(200.0, Currency.sar));

      // Operating Expenses = 30 SAR
      expect(report.totalOperatingExpenses, Money.fromMajor(30.0, Currency.sar));

      // Net Operating Profit = Gross Profit (200) - Operating Expenses (30) = 170 SAR
      expect(report.netProfit, Money.fromMajor(170.0, Currency.sar));

      // Personal Withdrawals = 70 SAR (Isolated and recorded)
      expect(report.totalPersonalWithdrawals, Money.fromMajor(70.0, Currency.sar));

      // Receivables remaining on order = 200 SAR
      expect(report.totalReceivables, Money.fromMajor(200.0, Currency.sar));
    });
  });
}
