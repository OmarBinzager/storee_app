import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('Storee AppDatabase Integration Tests', () {
    test('seeds initial currencies and default cash wallet on database creation', () async {
      final currencies = await db.select(db.currenciesTable).get();
      expect(currencies.length, 3);
      expect(currencies.map((c) => c.code).toSet(), containsAll(['YER', 'SAR', 'USD']));

      // YER minorUnitDigits is 0; SAR and USD are 2
      final yer = currencies.firstWhere((c) => c.code == 'YER');
      expect(yer.minorUnitDigits, 0);

      final sar = currencies.firstWhere((c) => c.code == 'SAR');
      expect(sar.minorUnitDigits, 2);

      // Default wallet
      final wallets = await db.select(db.walletsTable).get();
      expect(wallets.length, 1);
      expect(wallets.first.id, 'wallet-cash-default');

      // Default wallet balances
      final balances = await db.select(db.walletBalancesTable).get();
      expect(balances.length, 2);
    });

    test('inserts customer and related customer order with order items successfully', () async {
      // 1. Insert Customer
      const customerId = 'cust-101';
      await db.into(db.customersTable).insert(
            CustomersTableCompanion.insert(
              id: customerId,
              name: 'فاطمة الكاف',
              phone: '777123456',
              defaultCurrencyCode: 'SAR',
            ),
          );

      // 2. Insert Order
      const orderId = 'ord-202';
      await db.into(db.customerOrdersTable).insert(
            CustomerOrdersTableCompanion.insert(
              id: orderId,
              customerId: customerId,
              orderNumber: '#1050',
              executionStatus: 'newOrder',
              paymentStatus: 'unpaid',
              currencyCode: 'SAR',
              paidAmountMinor: const Value(0),
              discountAmountMinor: const Value(0),
            ),
          );

      // 3. Insert Order Item (minor unit: 150.00 SAR -> 15000 minor units)
      const itemId = 'item-303';
      await db.into(db.orderItemsTable).insert(
            OrderItemsTableCompanion.insert(
              id: itemId,
              orderId: orderId,
              title: 'فستان مخمل مطرز',
              quantity: const Value(2),
              saleUnitPriceMinor: 15000,
            ),
          );

      final items = await (db.select(db.orderItemsTable)..where((t) => t.orderId.equals(orderId))).get();
      expect(items.length, 1);
      expect(items.first.title, 'فستان مخمل مطرز');
      expect(items.first.saleUnitPriceMinor, 15000);
      expect(items.first.quantity, 2);
    });

    test('enforces foreign key constraints: inserting order with invalid customerId throws error', () async {
      expect(
        () async {
          await db.into(db.customerOrdersTable).insert(
                CustomerOrdersTableCompanion.insert(
                  id: 'ord-invalid',
                  customerId: 'nonexistent-customer-id',
                  orderNumber: '#9999',
                  executionStatus: 'newOrder',
                  paymentStatus: 'unpaid',
                  currencyCode: 'SAR',
                ),
              );
        },
        throwsA(isA<SqliteException>()),
      );
    });

    test('executes atomic financial transaction ensuring balance and transaction ledger consistency', () async {
      const walletId = 'wallet-cash-default';
      const currency = 'SAR';
      const paymentAmountMinor = 5000; // 50.00 SAR

      // Atomic transaction: update wallet balance and record financial ledger entry
      await db.transaction(() async {
        // 1. Update wallet balance
        final existing = await (db.select(db.walletBalancesTable)
              ..where((t) => t.walletId.equals(walletId) & t.currencyCode.equals(currency)))
            .getSingle();

        await (db.update(db.walletBalancesTable)
              ..where((t) => t.walletId.equals(walletId) & t.currencyCode.equals(currency)))
            .write(WalletBalancesTableCompanion(
          balanceMinor: Value(existing.balanceMinor + paymentAmountMinor),
        ));

        // 2. Insert into financial ledger
        await db.into(db.financialTransactionsTable).insert(
              FinancialTransactionsTableCompanion.insert(
                id: 'tx-test-1',
                type: 'paymentReceived',
                walletId: walletId,
                amountMinor: paymentAmountMinor,
                currencyCode: currency,
                occurredAt: DateTime.now(),
                notes: const Value('عربون نقدي'),
              ),
            );
      });

      // Verify balance was updated
      final updated = await (db.select(db.walletBalancesTable)
            ..where((t) => t.walletId.equals(walletId) & t.currencyCode.equals(currency)))
          .getSingle();
      expect(updated.balanceMinor, paymentAmountMinor);

      // Verify transaction was logged
      final transactions = await db.select(db.financialTransactionsTable).get();
      expect(transactions.length, 1);
      expect(transactions.first.amountMinor, paymentAmountMinor);
      expect(transactions.first.type, 'paymentReceived');
    });

    test('cascades delete on order items when an order is deleted', () async {
      // Setup customer, order, and item
      await db.into(db.customersTable).insert(
            CustomersTableCompanion.insert(
              id: 'cust-del',
              name: 'سارة',
              phone: '777000111',
              defaultCurrencyCode: 'SAR',
            ),
          );

      await db.into(db.customerOrdersTable).insert(
            CustomerOrdersTableCompanion.insert(
              id: 'ord-del',
              customerId: 'cust-del',
              orderNumber: '#2001',
              executionStatus: 'newOrder',
              paymentStatus: 'unpaid',
              currencyCode: 'SAR',
            ),
          );

      await db.into(db.orderItemsTable).insert(
            OrderItemsTableCompanion.insert(
              id: 'item-del',
              orderId: 'ord-del',
              title: 'عقد لؤلؤ',
              saleUnitPriceMinor: 8000,
            ),
          );

      // Verify item exists
      var items = await (db.select(db.orderItemsTable)..where((t) => t.orderId.equals('ord-del'))).get();
      expect(items.length, 1);

      // Delete order
      await (db.delete(db.customerOrdersTable)..where((t) => t.id.equals('ord-del'))).go();

      // Verify cascaded deletion
      items = await (db.select(db.orderItemsTable)..where((t) => t.orderId.equals('ord-del'))).get();
      expect(items.isEmpty, true);
    });
  });
}
