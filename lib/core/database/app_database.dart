import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'connection/open_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CurrenciesTable,
    WalletsTable,
    WalletBalancesTable,
    CustomersTable,
    ProductsTable,
    CustomerOrdersTable,
    OrderItemsTable,
    PurchaseBatchesTable,
    PurchaseBatchItemsTable,
    FinancialTransactionsTable,
    PaymentsTable,
    PaymentAllocationsTable,
    ExchangeRatesTable,
    ExpensesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openDatabaseConnection());

  /// In-memory database constructor for testing
  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Strictly enforce foreign key constraints
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();

          // 1. Seed supported currencies as mandated by Storee Specifications
          await batch((b) {
            b.insertAll(currenciesTable, [
              const CurrenciesTableCompanion(
                code: Value('YER'),
                nameAr: Value('ريال يمني'),
                symbolAr: Value('ر.ي'),
                minorUnitDigits: Value(0),
                isActive: Value(true),
              ),
              const CurrenciesTableCompanion(
                code: Value('SAR'),
                nameAr: Value('ريال سعودي'),
                symbolAr: Value('ر.س'),
                minorUnitDigits: Value(2),
                isActive: Value(true),
              ),
              const CurrenciesTableCompanion(
                code: Value('USD'),
                nameAr: Value('دولار أمريكي'),
                symbolAr: Value(r'$'),
                minorUnitDigits: Value(2),
                isActive: Value(true),
              ),
            ]);
          });

          // 2. Seed initial default cash wallet
          const defaultWalletId = 'wallet-cash-default';
          await into(walletsTable).insert(
            const WalletsTableCompanion(
              id: Value(defaultWalletId),
              name: Value('الخزينة النقدية (الكاش)'),
              type: Value('cash'),
              isActive: Value(true),
            ),
          );

          // 3. Initialize multi-currency zero balances for default wallet
          await batch((b) {
            b.insertAll(walletBalancesTable, [
              const WalletBalancesTableCompanion(
                walletId: Value(defaultWalletId),
                currencyCode: Value('YER'),
                balanceMinor: Value(0),
              ),
              const WalletBalancesTableCompanion(
                walletId: Value(defaultWalletId),
                currencyCode: Value('SAR'),
                balanceMinor: Value(0),
              ),
            ]);
          });
        },
      );
}
