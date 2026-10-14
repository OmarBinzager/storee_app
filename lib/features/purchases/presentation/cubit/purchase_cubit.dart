import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/purchase_batch.dart';
import '../../domain/repositories/purchase_repository.dart';
import 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final PurchaseRepository repository;

  PurchaseCubit(this.repository) : super(PurchaseInitial());

  Future<void> loadBatches() async {
    emit(PurchaseLoading());

    final batchesResult = await repository.getBatches();
    final itemsResult = await repository.getUnassignedOrderItems();

    batchesResult.fold(
      (failure) => emit(PurchaseError(failure.message)),
      (batches) {
        itemsResult.fold(
          (failure) => emit(PurchaseLoaded(batches: batches, unassignedItems: const [])),
          (items) => emit(PurchaseLoaded(batches: batches, unassignedItems: items)),
        );
      },
    );
  }

  Future<bool> createBatch({
    required String storeName,
    String? invoiceReference,
    required Currency currency,
    required Money extraCosts,
    required Money discounts,
    required List<BatchItemAllocated> items,
    String? payingWalletId,
    DateTime? purchasedAt,
  }) async {
    final result = await repository.createBatch(
      storeName: storeName,
      invoiceReference: invoiceReference,
      currency: currency,
      extraCosts: extraCosts,
      discounts: discounts,
      items: items,
      payingWalletId: payingWalletId,
      purchasedAt: purchasedAt,
    );

    return result.fold(
      (failure) {
        emit(PurchaseError(failure.message));
        return false;
      },
      (_) {
        loadBatches();
        return true;
      },
    );
  }
}
