import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../../domain/entities/purchase_batch.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../datasources/purchase_local_datasource.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseLocalDataSource localDataSource;

  PurchaseRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<PurchaseBatch>>> getBatches() async {
    try {
      final batches = await localDataSource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(DatabaseFailure('فشل في جلب فواتير الشراء الجماعي: $e'));
    }
  }

  @override
  Future<Either<Failure, List<OrderItem>>> getUnassignedOrderItems() async {
    try {
      final items = await localDataSource.getUnassignedOrderItems();
      return Right(items);
    } catch (e) {
      return Left(DatabaseFailure('فشل في جلب عناصر الطلبات غير المشتراة: $e'));
    }
  }

  @override
  Future<Either<Failure, PurchaseBatch>> createBatch({
    required String storeName,
    String? invoiceReference,
    required Currency currency,
    required Money extraCosts,
    required Money discounts,
    required List<BatchItemAllocated> items,
    String? payingWalletId,
    DateTime? purchasedAt,
  }) async {
    try {
      final batch = await localDataSource.createBatch(
        storeName: storeName,
        invoiceReference: invoiceReference,
        currency: currency,
        extraCosts: extraCosts,
        discounts: discounts,
        items: items,
        payingWalletId: payingWalletId,
        purchasedAt: purchasedAt,
      );
      return Right(batch);
    } catch (e) {
      return Left(DatabaseFailure('فشل في إنشاء دفعة الشراء الجماعي: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateBatchStatus(String batchId, PurchaseBatchStatus newStatus) async {
    try {
      await localDataSource.updateBatchStatus(batchId, newStatus);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تحديث حالة فاتورة الشراء: $e'));
    }
  }
}
