import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/order_item.dart';
import '../entities/purchase_batch.dart';

abstract class PurchaseRepository {
  Future<Either<Failure, List<PurchaseBatch>>> getBatches();

  /// Retrieves order items that have not yet been purchased (unitCost is null)
  Future<Either<Failure, List<OrderItem>>> getUnassignedOrderItems();

  /// Creates a purchase batch, allocates shipping/fees, updates order items' costs and execution status,
  /// and optionally logs payment to supplier from a wallet atomically.
  Future<Either<Failure, PurchaseBatch>> createBatch({
    required String storeName,
    String? invoiceReference,
    required Currency currency,
    required Money extraCosts,
    required Money discounts,
    required List<BatchItemAllocated> items,
    String? payingWalletId,
    DateTime? purchasedAt,
  });
}
