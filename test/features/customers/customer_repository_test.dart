import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/features/customers/data/datasources/customer_local_datasource.dart';
import 'package:storee/features/customers/data/repositories/customer_repository_impl.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';

void main() {
  late AppDatabase db;
  late CustomerLocalDataSource localDataSource;
  late CustomerRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.inMemory();
    localDataSource = CustomerLocalDataSourceImpl(db);
    repository = CustomerRepositoryImpl(localDataSource);
  });

  tearDown(() async {
    await db.close();
  });

  group('CustomerRepository Tests', () {
    test('successfully adds customer and retrieves customer from SQLite database', () async {
      final customer = Customer(
        id: 'cust-1',
        name: 'منى باوزير',
        phone: '733987654',
        defaultCurrency: Currency.yer,
        notes: 'دفع عبر ون كاش',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final addResult = await repository.addCustomer(customer);
      expect(addResult.isRight(), true);

      final listResult = await repository.getCustomers();
      expect(listResult.isRight(), true);

      listResult.fold(
        (_) => fail('Expected right'),
        (customers) {
          expect(customers.length, 1);
          expect(customers.first.name, 'منى باوزير');
          expect(customers.first.defaultCurrency.code, 'YER');
          expect(customers.first.phone, '733987654');
        },
      );
    });

    test('archives customer successfully without physical deletion', () async {
      final customer = Customer(
        id: 'cust-archive-test',
        name: 'أروى',
        phone: '711223344',
        defaultCurrency: Currency.sar,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repository.addCustomer(customer);
      final archiveResult = await repository.archiveCustomer('cust-archive-test');
      expect(archiveResult.isRight(), true);

      final listResult = await repository.getCustomers();
      listResult.fold(
        (_) => fail('Expected right'),
        (customers) {
          expect(customers.first.isArchived, true);
        },
      );
    });
  });
}
