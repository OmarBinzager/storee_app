import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/wallet.dart';

abstract class WalletLocalDataSource {
  Future<List<Wallet>> getWallets();
  Future<Wallet> createWallet({required String name, required WalletType type});
  Future<List<FinancialTransaction>> getRecentTransactions({int limit = 30});

  Future<void> recordPayment({
    required String customerId,
    required String walletId,
    required Money amount,
    required List<({String orderId, Money allocatedAmount})> allocations,
    String? notes,
  });

  Future<void> recordExpense({
    required String walletId,
    required Money amount,
    required String category,
    String? orderId,
    String? purchaseBatchId,
    String? notes,
  });

  Future<void> recordPersonalWithdrawal({
    required String walletId,
    required Money amount,
    String? notes,
  });

  Future<void> recordTransfer({
    required String fromWalletId,
    required String toWalletId,
    required Money amount,
    String? notes,
  });
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  final AppDatabase database;

  WalletLocalDataSourceImpl(this.database);

  @override
  Future<List<Wallet>> getWallets() async {
    final walletRows = await (database.select(database.walletsTable)
          ..where((t) => t.isActive.equals(true)))
        .get();

    final wallets = <Wallet>[];

    for (final w in walletRows) {
      final balanceRows = await (database.select(database.walletBalancesTable)
            ..where((t) => t.walletId.equals(w.id)))
          .get();

      final balances = <String, Money>{};
      for (final b in balanceRows) {
        final currency = Currency.fromCode(b.currencyCode);
        balances[b.currencyCode] = Money(
          amountMinor: b.balanceMinor,
          currency: currency,
        );
      }

      wallets.add(
        Wallet(
          id: w.id,
          name: w.name,
          type: _parseWalletType(w.type),
          isActive: w.isActive,
          balances: balances,
        ),
      );
    }

    return wallets;
  }

  @override
  Future<Wallet> createWallet({required String name, required WalletType type}) async {
    final walletId = const Uuid().v4();

    await database.transaction(() async {
      await database.into(database.walletsTable).insert(
            WalletsTableCompanion.insert(
              id: walletId,
              name: name,
              type: type.name,
              isActive: const Value(true),
            ),
          );

      // Initialize zero balances for all currencies
      for (final curr in Currency.values) {
        await database.into(database.walletBalancesTable).insert(
              WalletBalancesTableCompanion.insert(
                walletId: walletId,
                currencyCode: curr.code,
                balanceMinor: const Value(0),
              ),
            );
      }
    });

    final balances = {
      for (final curr in Currency.values) curr.code: Money.zero(curr),
    };

    return Wallet(
      id: walletId,
      name: name,
      type: type,
      isActive: true,
      balances: balances,
    );
  }

  @override
  Future<List<FinancialTransaction>> getRecentTransactions({int limit = 30}) async {
    final rows = await (database.select(database.financialTransactionsTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.occurredAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();

    return rows.map((r) {
      final currency = Currency.fromCode(r.currencyCode);
      return FinancialTransaction(
        id: r.id,
        type: _parseTransactionType(r.type),
        walletId: r.walletId,
        amount: Money(amountMinor: r.amountMinor, currency: currency),
        occurredAt: r.occurredAt,
        referenceId: r.referenceId,
        notes: r.notes,
      );
    }).toList();
  }

  @override
  Future<void> recordPayment({
    required String customerId,
    required String walletId,
    required Money amount,
    required List<({String orderId, Money allocatedAmount})> allocations,
    String? notes,
  }) async {
    final paymentId = const Uuid().v4();
    final now = DateTime.now();

    await database.transaction(() async {
      // 1. Record payment row
      await database.into(database.paymentsTable).insert(
            PaymentsTableCompanion.insert(
              id: paymentId,
              customerId: customerId,
              direction: 'inbound',
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              walletId: walletId,
              occurredAt: now,
              notes: Value(notes),
            ),
          );

      // 2. Insert allocations and update orders
      for (final alloc in allocations) {
        await database.into(database.paymentAllocationsTable).insert(
              PaymentAllocationsTableCompanion.insert(
                id: const Uuid().v4(),
                paymentId: paymentId,
                orderId: alloc.orderId,
                allocatedMinor: alloc.allocatedAmount.amountMinor,
                currencyCode: alloc.allocatedAmount.currency.code,
                createdAt: Value(now),
              ),
            );

        // Fetch current order to update paid amount and payment status
        final orderRow = await (database.select(database.customerOrdersTable)
              ..where((t) => t.id.equals(alloc.orderId)))
            .getSingle();

        if (alloc.allocatedAmount.currency.code != orderRow.currencyCode) {
          throw ArgumentError(
            'Currency mismatch: Order ${orderRow.orderNumber} is in ${orderRow.currencyCode}, '
            'but allocated amount is in ${alloc.allocatedAmount.currency.code}. '
            'Allocations to an order must be in the order\'s currency.',
          );
        }

        // Calculate total order amount from its items
        final itemRows = await (database.select(database.orderItemsTable)
              ..where((t) => t.orderId.equals(alloc.orderId)))
            .get();

        var totalItemsMinor = 0;
        for (final item in itemRows) {
          totalItemsMinor += (item.saleUnitPriceMinor * item.quantity);
        }
        final finalTotalMinor = totalItemsMinor - orderRow.discountAmountMinor;

        final newPaidMinor = orderRow.paidAmountMinor + alloc.allocatedAmount.amountMinor;
        final newPaymentStatus = (newPaidMinor >= finalTotalMinor)
            ? 'paid'
            : (newPaidMinor > 0 ? 'partial' : 'unpaid');

        await (database.update(database.customerOrdersTable)..where((t) => t.id.equals(alloc.orderId)))
            .write(
          CustomerOrdersTableCompanion(
            paidAmountMinor: Value(newPaidMinor),
            paymentStatus: Value(newPaymentStatus),
            updatedAt: Value(now),
          ),
        );
      }

      // 3. Increase wallet balance
      await _modifyWalletBalance(walletId, amount.currency.code, amount.amountMinor);

      // 4. Log in financial transaction ledger
      await database.into(database.financialTransactionsTable).insert(
            FinancialTransactionsTableCompanion.insert(
              id: const Uuid().v4(),
              type: TransactionType.paymentReceived.name,
              walletId: walletId,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              occurredAt: now,
              referenceId: Value(paymentId),
              notes: Value(notes ?? 'دفعة مستلمة من عميلة'),
              createdAt: Value(now),
            ),
          );
    });
  }

  @override
  Future<void> recordExpense({
    required String walletId,
    required Money amount,
    required String category,
    String? orderId,
    String? purchaseBatchId,
    String? notes,
  }) async {
    final expenseId = const Uuid().v4();
    final now = DateTime.now();

    await database.transaction(() async {
      // 1. Insert expense record
      await database.into(database.expensesTable).insert(
            ExpensesTableCompanion.insert(
              id: expenseId,
              category: category,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              walletId: walletId,
              orderId: Value(orderId),
              purchaseBatchId: Value(purchaseBatchId),
              notes: Value(notes),
              occurredAt: now,
            ),
          );

      // 2. Decrease wallet balance
      await _modifyWalletBalance(walletId, amount.currency.code, -amount.amountMinor);

      // 3. Log in ledger
      await database.into(database.financialTransactionsTable).insert(
            FinancialTransactionsTableCompanion.insert(
              id: const Uuid().v4(),
              type: TransactionType.operationalExpense.name,
              walletId: walletId,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              occurredAt: now,
              referenceId: Value(expenseId),
              notes: Value(notes ?? 'مصروف تشغيلي ($category)'),
              createdAt: Value(now),
            ),
          );
    });
  }

  @override
  Future<void> recordPersonalWithdrawal({
    required String walletId,
    required Money amount,
    String? notes,
  }) async {
    final withdrawalId = const Uuid().v4();
    final now = DateTime.now();

    await database.transaction(() async {
      // 1. Decrease wallet balance
      await _modifyWalletBalance(walletId, amount.currency.code, -amount.amountMinor);

      // 2. Log in ledger as personalWithdrawal (isolated from operational expenses)
      await database.into(database.financialTransactionsTable).insert(
            FinancialTransactionsTableCompanion.insert(
              id: const Uuid().v4(),
              type: TransactionType.personalWithdrawal.name,
              walletId: walletId,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              occurredAt: now,
              referenceId: Value(withdrawalId),
              notes: Value(notes ?? 'سحب شخصي للمالكة'),
              createdAt: Value(now),
            ),
          );
    });
  }

  @override
  Future<void> recordTransfer({
    required String fromWalletId,
    required String toWalletId,
    required Money amount,
    String? notes,
  }) async {
    final transferRef = 'transfer-${const Uuid().v4().substring(0, 8)}';
    final now = DateTime.now();

    await database.transaction(() async {
      // 1. Decrease source wallet
      await _modifyWalletBalance(fromWalletId, amount.currency.code, -amount.amountMinor);

      // 2. Increase destination wallet
      await _modifyWalletBalance(toWalletId, amount.currency.code, amount.amountMinor);

      // 3. Log TransferOut
      await database.into(database.financialTransactionsTable).insert(
            FinancialTransactionsTableCompanion.insert(
              id: const Uuid().v4(),
              type: TransactionType.transferOut.name,
              walletId: fromWalletId,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              occurredAt: now,
              referenceId: Value(transferRef),
              notes: Value('تحويل صادر إلى خزنة أخرى ${notes != null ? '($notes)' : ''}'),
              createdAt: Value(now),
            ),
          );

      // 4. Log TransferIn
      await database.into(database.financialTransactionsTable).insert(
            FinancialTransactionsTableCompanion.insert(
              id: const Uuid().v4(),
              type: TransactionType.transferIn.name,
              walletId: toWalletId,
              amountMinor: amount.amountMinor,
              currencyCode: amount.currency.code,
              occurredAt: now,
              referenceId: Value(transferRef),
              notes: Value('تحويل وارد من خزنة أخرى ${notes != null ? '($notes)' : ''}'),
              createdAt: Value(now),
            ),
          );
    });
  }

  Future<void> _modifyWalletBalance(String walletId, String currencyCode, int deltaMinor) async {
    final existing = await (database.select(database.walletBalancesTable)
          ..where((t) => t.walletId.equals(walletId) & t.currencyCode.equals(currencyCode)))
        .getSingleOrNull();

    if (existing != null) {
      await (database.update(database.walletBalancesTable)
            ..where((t) => t.walletId.equals(walletId) & t.currencyCode.equals(currencyCode)))
          .write(
        WalletBalancesTableCompanion(
          balanceMinor: Value(existing.balanceMinor + deltaMinor),
        ),
      );
    } else {
      await database.into(database.walletBalancesTable).insert(
            WalletBalancesTableCompanion.insert(
              walletId: walletId,
              currencyCode: currencyCode,
              balanceMinor: Value(deltaMinor),
            ),
          );
    }
  }

  WalletType _parseWalletType(String type) {
    return WalletType.values.firstWhere(
      (w) => w.name == type,
      orElse: () => WalletType.custom,
    );
  }

  TransactionType _parseTransactionType(String type) {
    return TransactionType.values.firstWhere(
      (t) => t.name == type,
      orElse: () => TransactionType.adjustment,
    );
  }
}
