import 'package:drift/drift.dart';

/// Table representing currencies supported in Storee (YER, SAR, USD)
class CurrenciesTable extends Table {
  @override
  String get tableName => 'currencies';

  TextColumn get code => text().withLength(min: 3, max: 5)();
  TextColumn get nameAr => text().withLength(min: 1, max: 50)();
  TextColumn get symbolAr => text().withLength(min: 1, max: 10)();
  IntColumn get minorUnitDigits => integer().withDefault(const Constant(2))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {code};
}

/// Table representing wallets (Cash, Bank Account, Electronic Wallet, Custom)
class WalletsTable extends Table {
  @override
  String get tableName => 'wallets';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // cash, bankAccount, electronicWallet, custom
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Balances per currency inside each wallet
class WalletBalancesTable extends Table {
  @override
  String get tableName => 'wallet_balances';

  TextColumn get walletId => text().references(WalletsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  IntColumn get balanceMinor => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {walletId, currencyCode};
}

/// Customers table
class CustomersTable extends Table {
  @override
  String get tableName => 'customers';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 150)();
  TextColumn get phone => text().withLength(min: 5, max: 30)();
  TextColumn get defaultCurrencyCode => text().references(CurrenciesTable, #code)();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Products snapshot/catalog table
class ProductsTable extends Table {
  @override
  String get tableName => 'products';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get imagePath => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get size => text().nullable()();
  TextColumn get purchaseUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Customer orders table
class CustomerOrdersTable extends Table {
  @override
  String get tableName => 'customer_orders';

  TextColumn get id => text()();
  TextColumn get customerId => text().references(CustomersTable, #id)();
  TextColumn get orderNumber => text().withLength(min: 1, max: 50)();
  TextColumn get executionStatus => text()(); // newOrder, confirmed, purchased, shipping, arrived, readyToDeliver, delivered, cancelled
  TextColumn get paymentStatus => text()(); // unpaid, partial, paid, refunded
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  IntColumn get paidAmountMinor => integer().withDefault(const Constant(0))();
  IntColumn get discountAmountMinor => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Order items table with preserved snapshots and minor unit costs
class OrderItemsTable extends Table {
  @override
  String get tableName => 'order_items';

  TextColumn get id => text()();
  TextColumn get orderId => text().references(CustomerOrdersTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId => text().references(ProductsTable, #id).nullable()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get color => text().nullable()();
  TextColumn get size => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get saleUnitPriceMinor => integer()();
  IntColumn get unitCostMinor => integer().nullable()();
  IntColumn get allocatedExtraCostMinor => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Purchase batches table for group purchases
class PurchaseBatchesTable extends Table {
  @override
  String get tableName => 'purchase_batches';

  TextColumn get id => text()();
  TextColumn get storeName => text().withLength(min: 1, max: 100)();
  TextColumn get invoiceReference => text().nullable()();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  IntColumn get extraCostsMinor => integer().withDefault(const Constant(0))();
  IntColumn get discountsMinor => integer().withDefault(const Constant(0))();
  TextColumn get status => text()(); // pending, purchased, arrived, distributed
  DateTimeColumn get purchasedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Items allocated within a purchase batch
class PurchaseBatchItemsTable extends Table {
  @override
  String get tableName => 'purchase_batch_items';

  TextColumn get id => text()();
  TextColumn get batchId => text().references(PurchaseBatchesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get orderItemId => text().references(OrderItemsTable, #id)();
  IntColumn get quantity => integer()();
  IntColumn get unitCostMinor => integer()();
  IntColumn get allocatedExtraCostMinor => integer().withDefault(const Constant(0))();
  TextColumn get manualOverrideReason => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Financial transaction ledger
class FinancialTransactionsTable extends Table {
  @override
  String get tableName => 'financial_transactions';

  TextColumn get id => text()();
  TextColumn get type => text()(); // paymentReceived, refundIssued, supplierPayment, operationalExpense, personalWithdrawal, transferIn, transferOut, adjustment
  TextColumn get walletId => text().references(WalletsTable, #id)();
  IntColumn get amountMinor => integer()();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Payments made by or refunded to customers
class PaymentsTable extends Table {
  @override
  String get tableName => 'payments';

  TextColumn get id => text()();
  TextColumn get customerId => text().references(CustomersTable, #id)();
  TextColumn get direction => text()(); // inbound (received), outbound (refund)
  IntColumn get amountMinor => integer()();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  TextColumn get walletId => text().references(WalletsTable, #id)();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Payment allocations against customer orders
class PaymentAllocationsTable extends Table {
  @override
  String get tableName => 'payment_allocations';

  TextColumn get id => text()();
  TextColumn get paymentId => text().references(PaymentsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get orderId => text().references(CustomerOrdersTable, #id)();
  IntColumn get allocatedMinor => integer()();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Exchange rates table
class ExchangeRatesTable extends Table {
  @override
  String get tableName => 'exchange_rates';

  TextColumn get id => text()();
  @ReferenceName('ratesFrom')
  TextColumn get fromCurrency => text().references(CurrenciesTable, #code)();

  @ReferenceName('ratesTo')
  TextColumn get toCurrency => text().references(CurrenciesTable, #code)();
  RealColumn get rateDecimal => real()();
  DateTimeColumn get effectiveAt => dateTime()();
  TextColumn get source => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Operational expenses table
class ExpensesTable extends Table {
  @override
  String get tableName => 'expenses';

  TextColumn get id => text()();
  TextColumn get category => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currencyCode => text().references(CurrenciesTable, #code)();
  TextColumn get walletId => text().references(WalletsTable, #id)();
  TextColumn get orderId => text().references(CustomerOrdersTable, #id).nullable()();
  TextColumn get purchaseBatchId => text().references(PurchaseBatchesTable, #id).nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
