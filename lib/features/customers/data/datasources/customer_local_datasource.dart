import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/money/currency.dart';
import '../../domain/entities/customer.dart';

abstract class CustomerLocalDataSource {
  Future<List<Customer>> getCustomers();
  Future<Customer> addCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> archiveCustomer(String id);
}

class CustomerLocalDataSourceImpl implements CustomerLocalDataSource {
  final AppDatabase database;

  CustomerLocalDataSourceImpl(this.database);

  @override
  Future<List<Customer>> getCustomers() async {
    final rows = await (database.select(database.customersTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();

    return rows.map(_mapRowToEntity).toList();
  }

  @override
  Future<Customer> addCustomer(Customer customer) async {
    await database.into(database.customersTable).insert(
          CustomersTableCompanion.insert(
            id: customer.id,
            name: customer.name,
            phone: customer.phone,
            defaultCurrencyCode: customer.defaultCurrency.code,
            notes: Value(customer.notes),
            isArchived: Value(customer.isArchived),
            createdAt: Value(customer.createdAt),
            updatedAt: Value(customer.updatedAt),
          ),
        );

    return customer;
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await (database.update(database.customersTable)..where((t) => t.id.equals(customer.id))).write(
      CustomersTableCompanion(
        name: Value(customer.name),
        phone: Value(customer.phone),
        defaultCurrencyCode: Value(customer.defaultCurrency.code),
        notes: Value(customer.notes),
        isArchived: Value(customer.isArchived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> archiveCustomer(String id) async {
    await (database.update(database.customersTable)..where((t) => t.id.equals(id))).write(
      const CustomersTableCompanion(
        isArchived: Value(true),
      ),
    );
  }

  Customer _mapRowToEntity(CustomersTableData row) {
    return Customer(
      id: row.id,
      name: row.name,
      phone: row.phone,
      defaultCurrency: Currency.fromCode(row.defaultCurrencyCode),
      notes: row.notes,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
