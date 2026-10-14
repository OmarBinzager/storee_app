import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/database/app_database.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/features/backup/data/datasources/backup_local_datasource.dart';
import 'package:storee/features/backup/data/repositories/backup_repository_impl.dart';
import 'package:storee/features/customers/data/datasources/customer_local_datasource.dart';
import 'package:storee/features/customers/domain/entities/customer.dart';
import 'package:storee/features/orders/data/datasources/order_local_datasource.dart';
import 'package:storee/features/orders/domain/entities/customer_order.dart';
import 'package:storee/features/orders/domain/entities/order_item.dart';
import 'package:storee/features/wallets/data/datasources/wallet_local_datasource.dart';
import 'package:storee/features/wallets/domain/entities/wallet.dart';

void main() {
  late AppDatabase db;
  late CustomerLocalDataSource customerDataSource;
  late OrderLocalDataSource orderDataSource;
  late WalletLocalDataSource walletDataSource;
  late BackupLocalDataSource backupDataSource;
  late BackupRepositoryImpl repository;
  late Directory tempBackupDir;

  setUp(() async {
    db = AppDatabase.inMemory();
    customerDataSource = CustomerLocalDataSourceImpl(db);
    orderDataSource = OrderLocalDataSourceImpl(db);
    walletDataSource = WalletLocalDataSourceImpl(db);
    backupDataSource = BackupLocalDataSourceImpl(db);
    repository = BackupRepositoryImpl(backupDataSource);
    tempBackupDir = await Directory.systemTemp.createTemp('storee_test_backup_');
  });

  tearDown(() async {
    await db.close();
    if (await tempBackupDir.exists()) {
      await tempBackupDir.delete(recursive: true);
    }
  });

  group('BackupRepository Integrity & Restoration Invariants Tests', () {
    test('creates backup, verifies SHA-256 checksum, and restores data completely after wipe', () async {
      final now = DateTime.now();

      // 1. Create seed data: Customer
      const customerId = 'cust-backup-1';
      await customerDataSource.addCustomer(
        Customer(
          id: customerId,
          name: 'خلود باهرمز',
          phone: '777445566',
          defaultCurrency: Currency.sar,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 2. Create seed data: Order with Item
      const orderId = 'ord-backup-1';
      await orderDataSource.createOrder(
        CustomerOrder(
          id: orderId,
          customerId: customerId,
          customerName: 'خلود باهرمز',
          orderNumber: '#BK-99',
          executionStatus: OrderExecutionStatus.confirmed,
          paymentStatus: OrderPaymentStatus.partial,
          currency: Currency.sar,
          items: [
            OrderItem(
              id: 'item-bk-1',
              orderId: orderId,
              title: 'جلابية مطرزة يدوي',
              quantity: 2,
              saleUnitPrice: Money.fromMajor(180.0, Currency.sar),
            ),
          ],
          paidAmount: Money.fromMajor(150.0, Currency.sar),
          discountAmount: Money.zero(Currency.sar),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 3. Create seed data: Wallet
      final wallet = await walletDataSource.createWallet(
        name: 'حساب العمقي للصرافة',
        type: WalletType.electronicWallet,
      );

      // 4. Create Backup Snapshot
      final backupResult = await repository.createBackup(customDirectory: tempBackupDir.path);
      expect(backupResult.isRight(), true);

      final metadata = backupResult.getOrElse(() => throw Exception());
      expect(metadata.customerCount, 1);
      expect(metadata.orderCount, 1);
      expect(metadata.checksum.isNotEmpty, true);
      expect(File(metadata.filePath).existsSync(), true);

      // 5. Inspect Backup: Integrity check passes
      final inspectResult = await repository.inspectBackup(metadata.filePath);
      expect(inspectResult.isRight(), true);

      // 6. Inspect Tampered Backup: detect manipulation
      final tamperedFile = File('${tempBackupDir.path}/tampered.storee');
      final originalContent = await File(metadata.filePath).readAsString();
      // Replace a character in the data section
      final tamperedContent = originalContent.replaceAll('جلابية', 'فستان');
      await tamperedFile.writeAsString(tamperedContent);

      final tamperedResult = await repository.inspectBackup(tamperedFile.path);
      expect(tamperedResult.isLeft(), true);
      tamperedResult.fold(
        (failure) => expect(failure.message.contains('Checksum mismatch'), true),
        (_) => fail('Expected checksum failure'),
      );

      // 7. Wipe Database (Simulate Disaster / Device Switch)
      await db.delete(db.customerOrdersTable).go();
      await db.delete(db.customersTable).go();
      await db.delete(db.walletsTable).go();

      // Verify empty
      final customersBefore = await customerDataSource.getCustomers();
      expect(customersBefore.isEmpty, true);

      // 8. Restore from backup
      final restoreResult = await repository.restoreBackup(metadata.filePath);
      expect(restoreResult.isRight(), true);

      // 9. Verify full recovery of records
      final customersAfter = await customerDataSource.getCustomers();
      expect(customersAfter.length, 1);
      expect(customersAfter.first.name, 'خلود باهرمز');

      final ordersAfter = await orderDataSource.getOrders();
      expect(ordersAfter.length, 1);
      expect(ordersAfter.first.orderNumber, '#BK-99');
      expect(ordersAfter.first.items.length, 1);
      expect(ordersAfter.first.items.first.title, 'جلابية مطرزة يدوي');
      expect(ordersAfter.first.totalAmount, Money.fromMajor(360.0, Currency.sar));

      final walletsAfter = await walletDataSource.getWallets();
      expect(walletsAfter.any((w) => w.id == wallet.id), true);
    });
  });
}
