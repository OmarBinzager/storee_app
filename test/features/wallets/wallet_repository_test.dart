import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/features/customers/data/datasources/customer_local_datasource.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';
import 'package:storee/features/orders/data/datasources/order_local_datasource.dart';
import 'package:storee/features/orders/domain/entities/customer_order.dart';
import 'package:storee/features/orders/domain/entities/order_item.dart';
import 'package:storee/features/wallets/data/datasources/wallet_local_datasource.dart';
import 'package:storee/features/wallets/data/repositories/wallet_repository_impl.dart';
import 'package:storee/features/wallets/domain/entities/wallet.dart';

void main() {
  late AppDatabase db;
  late WalletLocalDataSource walletDataSource;
  late CustomerLocalDataSource customerDataSource;
  late OrderLocalDataSource orderDataSource;
  late WalletRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.inMemory();
    walletDataSource = WalletLocalDataSourceImpl(db);
    customerDataSource = CustomerLocalDataSourceImpl(db);
    orderDataSource = OrderLocalDataSourceImpl(db);
    repository = WalletRepositoryImpl(walletDataSource);
  });

  tearDown(() async {
    await db.close();
  });

  group('WalletRepository Financial Invariant Tests', () {
    test('creates new wallet with multi-currency zero balances', () async {
      final result = await repository.createWallet(
        name: 'بنك الكريمي المميز',
        type: WalletType.bankAccount,
      );

      expect(result.isRight(), true);

      final walletsResult = await repository.getWallets();
      walletsResult.fold(
        (_) => fail('Expected right'),
        (wallets) {
          final kuraimi = wallets.firstWhere((w) => w.name == 'بنك الكريمي المميز');
          expect(kuraimi.type, WalletType.bankAccount);
          expect(kuraimi.getBalanceFor(Currency.sar).amountMinor, 0);
          expect(kuraimi.getBalanceFor(Currency.yer).amountMinor, 0);
        },
      );
    });

    test('records payment, updates order paid status, and increases wallet balance atomically', () async {
      // 1. Create Customer
      const customerId = 'cust-pay-test';
      await customerDataSource.addCustomer(
        Customer(
          id: customerId,
          name: 'فاطمة الكاف',
          phone: '777000000',
          defaultCurrency: Currency.sar,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // 2. Create Order for 150.00 SAR
      const orderId = 'ord-pay-test';
      await orderDataSource.createOrder(
        CustomerOrder(
          id: orderId,
          customerId: customerId,
          customerName: 'فاطمة الكاف',
          orderNumber: '#1099',
          executionStatus: OrderExecutionStatus.newOrder,
          paymentStatus: OrderPaymentStatus.unpaid,
          currency: Currency.sar,
          items: [
            OrderItem(
              id: 'item-pay-1',
              orderId: orderId,
              title: 'فستان مخمل مطرز',
              quantity: 1,
              saleUnitPrice: Money.fromMajor(150, Currency.sar),
            ),
          ],
          paidAmount: Money.zero(Currency.sar),
          discountAmount: Money.zero(Currency.sar),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // 3. Receive 100.00 SAR payment into default cash wallet
      const defaultCashWalletId = 'wallet-cash-default';
      final paymentAmount = Money.fromMajor(100, Currency.sar);

      final payResult = await repository.recordPayment(
        customerId: customerId,
        walletId: defaultCashWalletId,
        amount: paymentAmount,
        allocations: [(orderId: orderId, allocatedAmount: paymentAmount)],
        notes: 'دفعة أولى عربون',
      );

      expect(payResult.isRight(), true);

      // 4. Verify wallet balance increased to 100.00 SAR
      final walletsResult = await repository.getWallets();
      walletsResult.fold(
        (_) => fail('Expected right'),
        (wallets) {
          final defaultWallet = wallets.firstWhere((w) => w.id == defaultCashWalletId);
          expect(defaultWallet.getBalanceFor(Currency.sar).toMajor, 100.0);
        },
      );

      // 5. Verify order paidAmount updated to 100.00 SAR and paymentStatus is 'partial'
      final orders = await orderDataSource.getOrders();
      final updatedOrder = orders.firstWhere((o) => o.id == orderId);
      expect(updatedOrder.paidAmount.toMajor, 100.0);
      expect(updatedOrder.remainingAmount.toMajor, 50.0);
      expect(updatedOrder.paymentStatus, OrderPaymentStatus.partial);

      // 6. Verify ledger transaction recorded
      final txResult = await repository.getRecentTransactions();
      txResult.fold(
        (_) => fail('Expected right'),
        (txs) {
          expect(txs.length, 1);
          expect(txs.first.type, TransactionType.paymentReceived);
          expect(txs.first.amount.toMajor, 100.0);
        },
      );
    });

    test('records operational expense and decreases wallet balance', () async {
      const defaultCashWalletId = 'wallet-cash-default';

      final expenseAmount = Money.fromMajor(25, Currency.sar);
      final expenseResult = await repository.recordExpense(
        walletId: defaultCashWalletId,
        amount: expenseAmount,
        category: 'تغليف وهدايا',
        notes: 'شراء أكياس تغليف وبطاقات شكر',
      );

      expect(expenseResult.isRight(), true);

      // Check balance decreased (was 0, now -25.00 SAR)
      final walletsResult = await repository.getWallets();
      walletsResult.fold(
        (_) => fail('Expected right'),
        (wallets) {
          final defaultWallet = wallets.firstWhere((w) => w.id == defaultCashWalletId);
          expect(defaultWallet.getBalanceFor(Currency.sar).toMajor, -25.0);
        },
      );
    });

    test('internal transfer between wallets transfers exact funds and leaves total assets unchanged', () async {
      const sourceWalletId = 'wallet-cash-default';

      // Create second wallet
      final secondWalletResult = await repository.createWallet(
        name: 'محفظة جيب كاش',
        type: WalletType.electronicWallet,
      );
      late String destWalletId;
      secondWalletResult.fold(
        (_) => fail('Expected right'),
        (w) => destWalletId = w.id,
      );

      final transferAmount = Money.fromMajor(50, Currency.sar);

      final transferResult = await repository.recordTransfer(
        fromWalletId: sourceWalletId,
        toWalletId: destWalletId,
        amount: transferAmount,
        notes: 'إيداع رصيد بالمحفظة',
      );

      expect(transferResult.isRight(), true);

      final walletsResult = await repository.getWallets();
      walletsResult.fold(
        (_) => fail('Expected right'),
        (wallets) {
          final source = wallets.firstWhere((w) => w.id == sourceWalletId);
          final dest = wallets.firstWhere((w) => w.id == destWalletId);

          expect(source.getBalanceFor(Currency.sar).toMajor, -50.0);
          expect(dest.getBalanceFor(Currency.sar).toMajor, 50.0);

          // Total sum across wallets: -50 + 50 = 0 (No income or expense created!)
          final totalSum = source.getBalanceFor(Currency.sar) + dest.getBalanceFor(Currency.sar);
          expect(totalSum.amountMinor, 0);
        },
      );
    });
  });
}
