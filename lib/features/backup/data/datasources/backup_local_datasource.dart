import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/backup_metadata.dart';

abstract class BackupLocalDataSource {
  Future<BackupMetadata> createBackup({String? customDirectory});
  Future<BackupMetadata> inspectBackup(String filePath);
  Future<void> restoreBackup(String filePath);
  Future<List<BackupMetadata>> listLocalBackups();
}

class BackupLocalDataSourceImpl implements BackupLocalDataSource {
  final AppDatabase database;

  BackupLocalDataSourceImpl(this.database);

  Future<Directory> _getBackupsDirectory({String? customDirectory}) async {
    if (customDirectory != null) {
      final dir = Directory(customDirectory);
      if (!await dir.exists()) await dir.create(recursive: true);
      return dir;
    }
    final appDocDir = await getApplicationDocumentsDirectory();
    final backupsDir = Directory(p.join(appDocDir.path, 'storee_backups'));
    if (!await backupsDir.exists()) {
      await backupsDir.create(recursive: true);
    }
    return backupsDir;
  }

  @override
  Future<BackupMetadata> createBackup({String? customDirectory}) async {
    final now = DateTime.now();

    // 1. Collect all rows from tables
    final currencies = await database.select(database.currenciesTable).get();
    final wallets = await database.select(database.walletsTable).get();
    final walletBalances = await database.select(database.walletBalancesTable).get();
    final customers = await database.select(database.customersTable).get();
    final orders = await database.select(database.customerOrdersTable).get();
    final orderItems = await database.select(database.orderItemsTable).get();
    final payments = await database.select(database.paymentsTable).get();
    final paymentAllocations = await database.select(database.paymentAllocationsTable).get();
    final expenses = await database.select(database.expensesTable).get();
    final purchaseBatches = await database.select(database.purchaseBatchesTable).get();
    final purchaseBatchItems = await database.select(database.purchaseBatchItemsTable).get();
    final transactions = await database.select(database.financialTransactionsTable).get();

    final dataPayload = {
      'currencies': currencies.map((c) => {
            'code': c.code,
            'nameAr': c.nameAr,
            'symbolAr': c.symbolAr,
            'minorUnitDigits': c.minorUnitDigits,
            'isActive': c.isActive,
          }).toList(),
      'wallets': wallets.map((w) => {
            'id': w.id,
            'name': w.name,
            'type': w.type,
            'isActive': w.isActive,
            'createdAt': w.createdAt.toIso8601String(),
          }).toList(),
      'walletBalances': walletBalances.map((b) => {
            'walletId': b.walletId,
            'currencyCode': b.currencyCode,
            'balanceMinor': b.balanceMinor,
          }).toList(),
      'customers': customers.map((c) => {
            'id': c.id,
            'name': c.name,
            'phone': c.phone,
            'defaultCurrencyCode': c.defaultCurrencyCode,
            'notes': c.notes,
            'isArchived': c.isArchived,
            'createdAt': c.createdAt.toIso8601String(),
            'updatedAt': c.updatedAt.toIso8601String(),
          }).toList(),
      'orders': orders.map((o) => {
            'id': o.id,
            'customerId': o.customerId,
            'orderNumber': o.orderNumber,
            'executionStatus': o.executionStatus,
            'paymentStatus': o.paymentStatus,
            'currencyCode': o.currencyCode,
            'paidAmountMinor': o.paidAmountMinor,
            'discountAmountMinor': o.discountAmountMinor,
            'notes': o.notes,
            'createdAt': o.createdAt.toIso8601String(),
            'updatedAt': o.updatedAt.toIso8601String(),
          }).toList(),
      'orderItems': orderItems.map((i) => {
            'id': i.id,
            'orderId': i.orderId,
            'productId': i.productId,
            'title': i.title,
            'color': i.color,
            'size': i.size,
            'quantity': i.quantity,
            'saleUnitPriceMinor': i.saleUnitPriceMinor,
            'unitCostMinor': i.unitCostMinor,
            'allocatedExtraCostMinor': i.allocatedExtraCostMinor,
          }).toList(),
      'payments': payments.map((p) => {
            'id': p.id,
            'customerId': p.customerId,
            'direction': p.direction,
            'amountMinor': p.amountMinor,
            'currencyCode': p.currencyCode,
            'walletId': p.walletId,
            'occurredAt': p.occurredAt.toIso8601String(),
            'notes': p.notes,
          }).toList(),
      'paymentAllocations': paymentAllocations.map((a) => {
            'id': a.id,
            'paymentId': a.paymentId,
            'orderId': a.orderId,
            'allocatedMinor': a.allocatedMinor,
            'currencyCode': a.currencyCode,
            'createdAt': a.createdAt.toIso8601String(),
          }).toList(),
      'expenses': expenses.map((e) => {
            'id': e.id,
            'category': e.category,
            'amountMinor': e.amountMinor,
            'currencyCode': e.currencyCode,
            'walletId': e.walletId,
            'orderId': e.orderId,
            'purchaseBatchId': e.purchaseBatchId,
            'notes': e.notes,
            'occurredAt': e.occurredAt.toIso8601String(),
          }).toList(),
      'purchaseBatches': purchaseBatches.map((b) => {
            'id': b.id,
            'storeName': b.storeName,
            'invoiceReference': b.invoiceReference,
            'currencyCode': b.currencyCode,
            'extraCostsMinor': b.extraCostsMinor,
            'discountsMinor': b.discountsMinor,
            'status': b.status,
            'purchasedAt': b.purchasedAt.toIso8601String(),
            'createdAt': b.createdAt.toIso8601String(),
          }).toList(),
      'purchaseBatchItems': purchaseBatchItems.map((i) => {
            'id': i.id,
            'batchId': i.batchId,
            'orderItemId': i.orderItemId,
            'quantity': i.quantity,
            'unitCostMinor': i.unitCostMinor,
            'allocatedExtraCostMinor': i.allocatedExtraCostMinor,
            'manualOverrideReason': i.manualOverrideReason,
          }).toList(),
      'transactions': transactions.map((t) => {
            'id': t.id,
            'type': t.type,
            'walletId': t.walletId,
            'amountMinor': t.amountMinor,
            'currencyCode': t.currencyCode,
            'occurredAt': t.occurredAt.toIso8601String(),
            'referenceId': t.referenceId,
            'notes': t.notes,
            'createdAt': t.createdAt.toIso8601String(),
          }).toList(),
    };

    final rawJsonData = jsonEncode(dataPayload);
    final dataBytes = utf8.encode(rawJsonData);
    final checksum = sha256.convert(dataBytes).toString();

    final dir = await _getBackupsDirectory(customDirectory: customDirectory);
    final timestampStr = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final fileName = 'storee_backup_$timestampStr.storee';
    final filePath = p.join(dir.path, fileName);

    final metadata = BackupMetadata(
      filePath: filePath,
      fileName: fileName,
      version: '1.0.0',
      createdAt: now,
      checksum: checksum,
      customerCount: customers.length,
      orderCount: orders.length,
      walletCount: wallets.length,
      transactionCount: transactions.length,
      purchaseBatchCount: purchaseBatches.length,
      payloadSizeBytes: dataBytes.length,
    );

    final envelope = {
      'magic': 'STOREE_BACKUP_V1',
      'metadata': metadata.toJson(),
      'data': dataPayload,
    };

    final file = File(filePath);
    await file.writeAsString(jsonEncode(envelope));

    return metadata;
  }

  @override
  Future<BackupMetadata> inspectBackup(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw const BackupException('ملف النسخة الاحتياطية غير موجود');
    }

    try {
      final content = await file.readAsString();
      final envelope = jsonDecode(content) as Map<String, dynamic>;

      if (envelope['magic'] != 'STOREE_BACKUP_V1') {
        throw const BackupException('صيغة ملف النسخ الاحتياطي غير متوافقة مع تطبيق ستوري');
      }

      final metadataJson = envelope['metadata'] as Map<String, dynamic>;
      final dataJson = envelope['data'] as Map<String, dynamic>;

      final rawDataString = jsonEncode(dataJson);
      final computedChecksum = sha256.convert(utf8.encode(rawDataString)).toString();
      final expectedChecksum = metadataJson['checksum'] as String;

      if (computedChecksum != expectedChecksum) {
        throw const BackupException('فشل فحص السلامة (Checksum mismatch): قد يكون الملف تالفاً أو تم التعديل عليه');
      }

      return BackupMetadata.fromJson(
        metadataJson,
        filePath: filePath,
        fileName: p.basename(filePath),
      );
    } catch (e) {
      if (e is BackupException) rethrow;
      throw BackupException('فشل في فحص وقراءة النسخة الاحتياطية: $e');
    }
  }

  @override
  Future<void> restoreBackup(String filePath) async {
    // 1. Inspect and verify checksum
    await inspectBackup(filePath);

    final file = File(filePath);
    final content = await file.readAsString();
    final envelope = jsonDecode(content) as Map<String, dynamic>;
    final data = envelope['data'] as Map<String, dynamic>;

    await database.transaction(() async {
      // Clear tables in reverse dependency order
      await database.delete(database.financialTransactionsTable).go();
      await database.delete(database.purchaseBatchItemsTable).go();
      await database.delete(database.purchaseBatchesTable).go();
      await database.delete(database.paymentAllocationsTable).go();
      await database.delete(database.paymentsTable).go();
      await database.delete(database.expensesTable).go();
      await database.delete(database.orderItemsTable).go();
      await database.delete(database.customerOrdersTable).go();
      await database.delete(database.walletBalancesTable).go();
      await database.delete(database.walletsTable).go();
      await database.delete(database.customersTable).go();
      await database.delete(database.currenciesTable).go();

      // Restore Currencies
      final currencies = (data['currencies'] as List<dynamic>?) ?? [];
      for (final c in currencies) {
        await database.into(database.currenciesTable).insert(
              CurrenciesTableCompanion.insert(
                code: c['code'],
                nameAr: c['nameAr'],
                symbolAr: c['symbolAr'],
                minorUnitDigits: Value(c['minorUnitDigits'] ?? 2),
                isActive: Value(c['isActive'] ?? true),
              ),
            );
      }

      // Restore Wallets
      final wallets = (data['wallets'] as List<dynamic>?) ?? [];
      for (final w in wallets) {
        await database.into(database.walletsTable).insert(
              WalletsTableCompanion.insert(
                id: w['id'],
                name: w['name'],
                type: w['type'],
                isActive: Value(w['isActive'] ?? true),
                createdAt: Value(DateTime.parse(w['createdAt'])),
              ),
            );
      }

      // Restore Wallet Balances
      final balances = (data['walletBalances'] as List<dynamic>?) ?? [];
      for (final b in balances) {
        await database.into(database.walletBalancesTable).insert(
              WalletBalancesTableCompanion.insert(
                walletId: b['walletId'],
                currencyCode: b['currencyCode'],
                balanceMinor: Value(b['balanceMinor'] ?? 0),
              ),
            );
      }

      // Restore Customers
      final customers = (data['customers'] as List<dynamic>?) ?? [];
      for (final c in customers) {
        await database.into(database.customersTable).insert(
              CustomersTableCompanion.insert(
                id: c['id'],
                name: c['name'],
                phone: c['phone'],
                defaultCurrencyCode: c['defaultCurrencyCode'],
                notes: Value(c['notes']),
                isArchived: Value(c['isArchived'] ?? false),
                createdAt: Value(DateTime.parse(c['createdAt'])),
                updatedAt: Value(DateTime.parse(c['updatedAt'])),
              ),
            );
      }

      // Restore Orders
      final orders = (data['orders'] as List<dynamic>?) ?? [];
      for (final o in orders) {
        await database.into(database.customerOrdersTable).insert(
              CustomerOrdersTableCompanion.insert(
                id: o['id'],
                customerId: o['customerId'],
                orderNumber: o['orderNumber'],
                executionStatus: o['executionStatus'] ?? 'newOrder',
                paymentStatus: o['paymentStatus'] ?? 'unpaid',
                currencyCode: o['currencyCode'],
                paidAmountMinor: Value(o['paidAmountMinor'] ?? 0),
                discountAmountMinor: Value(o['discountAmountMinor'] ?? 0),
                notes: Value(o['notes']),
                createdAt: Value(DateTime.parse(o['createdAt'])),
                updatedAt: Value(DateTime.parse(o['updatedAt'])),
              ),
            );
      }

      // Restore Order Items
      final orderItems = (data['orderItems'] as List<dynamic>?) ?? [];
      for (final i in orderItems) {
        await database.into(database.orderItemsTable).insert(
              OrderItemsTableCompanion.insert(
                id: i['id'],
                orderId: i['orderId'],
                productId: Value(i['productId']),
                title: i['title'],
                color: Value(i['color']),
                size: Value(i['size']),
                quantity: Value(i['quantity'] ?? 1),
                saleUnitPriceMinor: i['saleUnitPriceMinor'],
                unitCostMinor: Value(i['unitCostMinor']),
                allocatedExtraCostMinor: Value(i['allocatedExtraCostMinor']),
              ),
            );
      }

      // Restore Payments
      final payments = (data['payments'] as List<dynamic>?) ?? [];
      for (final p in payments) {
        await database.into(database.paymentsTable).insert(
              PaymentsTableCompanion.insert(
                id: p['id'],
                customerId: p['customerId'],
                direction: p['direction'] ?? 'inbound',
                amountMinor: p['amountMinor'],
                currencyCode: p['currencyCode'],
                walletId: p['walletId'],
                occurredAt: DateTime.parse(p['occurredAt']),
                notes: Value(p['notes']),
              ),
            );
      }

      // Restore Payment Allocations
      final allocations = (data['paymentAllocations'] as List<dynamic>?) ?? [];
      for (final a in allocations) {
        await database.into(database.paymentAllocationsTable).insert(
              PaymentAllocationsTableCompanion.insert(
                id: a['id'],
                paymentId: a['paymentId'],
                orderId: a['orderId'],
                allocatedMinor: a['allocatedMinor'],
                currencyCode: a['currencyCode'],
                createdAt: Value(DateTime.parse(a['createdAt'])),
              ),
            );
      }

      // Restore Expenses
      final expenses = (data['expenses'] as List<dynamic>?) ?? [];
      for (final e in expenses) {
        await database.into(database.expensesTable).insert(
              ExpensesTableCompanion.insert(
                id: e['id'],
                category: e['category'],
                amountMinor: e['amountMinor'],
                currencyCode: e['currencyCode'],
                walletId: e['walletId'],
                orderId: Value(e['orderId']),
                purchaseBatchId: Value(e['purchaseBatchId']),
                notes: Value(e['notes']),
                occurredAt: DateTime.parse(e['occurredAt']),
              ),
            );
      }

      // Restore Purchase Batches
      final purchaseBatches = (data['purchaseBatches'] as List<dynamic>?) ?? [];
      for (final b in purchaseBatches) {
        await database.into(database.purchaseBatchesTable).insert(
              PurchaseBatchesTableCompanion.insert(
                id: b['id'],
                storeName: b['storeName'],
                invoiceReference: Value(b['invoiceReference']),
                currencyCode: b['currencyCode'],
                extraCostsMinor: Value(b['extraCostsMinor'] ?? 0),
                discountsMinor: Value(b['discountsMinor'] ?? 0),
                status: b['status'] ?? 'purchased',
                purchasedAt: DateTime.parse(b['purchasedAt']),
                createdAt: Value(DateTime.parse(b['createdAt'])),
              ),
            );
      }

      // Restore Purchase Batch Items
      final purchaseBatchItems = (data['purchaseBatchItems'] as List<dynamic>?) ?? [];
      for (final i in purchaseBatchItems) {
        await database.into(database.purchaseBatchItemsTable).insert(
              PurchaseBatchItemsTableCompanion.insert(
                id: i['id'],
                batchId: i['batchId'],
                orderItemId: i['orderItemId'],
                quantity: i['quantity'] ?? 1,
                unitCostMinor: i['unitCostMinor'],
                allocatedExtraCostMinor: Value(i['allocatedExtraCostMinor'] ?? 0),
                manualOverrideReason: Value(i['manualOverrideReason']),
              ),
            );
      }

      // Restore Financial Transactions
      final transactions = (data['transactions'] as List<dynamic>?) ?? [];
      for (final t in transactions) {
        await database.into(database.financialTransactionsTable).insert(
              FinancialTransactionsTableCompanion.insert(
                id: t['id'],
                type: t['type'],
                walletId: t['walletId'],
                amountMinor: t['amountMinor'],
                currencyCode: t['currencyCode'],
                occurredAt: DateTime.parse(t['occurredAt']),
                referenceId: Value(t['referenceId']),
                notes: Value(t['notes']),
                createdAt: Value(DateTime.parse(t['createdAt'])),
              ),
            );
      }
    });
  }

  @override
  Future<List<BackupMetadata>> listLocalBackups() async {
    final dir = await _getBackupsDirectory();
    final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.storee')).toList();

    final result = <BackupMetadata>[];
    for (final f in files) {
      try {
        final meta = await inspectBackup(f.path);
        result.add(meta);
      } catch (_) {
        // Skip corrupted or unreadable backup files in list
      }
    }

    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return result;
  }
}
