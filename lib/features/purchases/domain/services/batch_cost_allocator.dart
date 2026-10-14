import '../../../../core/money/money.dart';
import '../entities/purchase_batch.dart';

/// Implements the proportional cost distribution algorithm required by Storee specifications.
/// Extra costs (shipping, customs, packaging) minus batch discounts are allocated to each item
/// proportionally based on its relative base cost.
/// Any rounding discrepancies are adjusted on the largest item to preserve 100% mathematical equality.
class BatchCostAllocator {
  const BatchCostAllocator();

  List<BatchItemAllocated> allocate({
    required List<({String orderItemId, String title, int quantity, Money baseCost})> rawItems,
    required Money extraCosts,
    required Money discounts,
  }) {
    if (rawItems.isEmpty) return const [];

    final currency = extraCosts.currency;
    final netExtraToAllocate = extraCosts - discounts;

    // Calculate sum of base costs
    var totalBaseMinor = 0;
    for (final item in rawItems) {
      if (item.baseCost.currency.code != currency.code) {
        throw CurrencyMismatchException(item.baseCost.currency.code, currency.code);
      }
      totalBaseMinor += item.baseCost.amountMinor;
    }

    if (totalBaseMinor == 0) {
      // If base cost is 0, distribute equally
      final shareMinor = (netExtraToAllocate.amountMinor / rawItems.length).round();
      return rawItems.map((item) {
        return BatchItemAllocated(
          orderItemId: item.orderItemId,
          title: item.title,
          quantity: item.quantity,
          baseCost: item.baseCost,
          allocatedExtraCost: Money(amountMinor: shareMinor, currency: currency),
        );
      }).toList();
    }

    var allocatedTotalMinor = 0;
    int maxItemIndex = 0;
    int maxBaseMinor = -1;

    final allocatedList = <BatchItemAllocated>[];

    for (var i = 0; i < rawItems.length; i++) {
      final item = rawItems[i];
      if (item.baseCost.amountMinor > maxBaseMinor) {
        maxBaseMinor = item.baseCost.amountMinor;
        maxItemIndex = i;
      }

      // Proportional ratio: (item base / total base) * net extra
      final ratio = item.baseCost.amountMinor / totalBaseMinor;
      final allocatedMinor = (netExtraToAllocate.amountMinor * ratio).round();
      allocatedTotalMinor += allocatedMinor;

      allocatedList.add(
        BatchItemAllocated(
          orderItemId: item.orderItemId,
          title: item.title,
          quantity: item.quantity,
          baseCost: item.baseCost,
          allocatedExtraCost: Money(amountMinor: allocatedMinor, currency: currency),
        ),
      );
    }

    // Fix rounding discrepancies (difference of a few minor units / cents)
    final difference = netExtraToAllocate.amountMinor - allocatedTotalMinor;
    if (difference != 0) {
      final target = allocatedList[maxItemIndex];
      allocatedList[maxItemIndex] = BatchItemAllocated(
        orderItemId: target.orderItemId,
        title: target.title,
        quantity: target.quantity,
        baseCost: target.baseCost,
        allocatedExtraCost: Money(
          amountMinor: target.allocatedExtraCost.amountMinor + difference,
          currency: currency,
        ),
        manualOverrideReason: 'تعديل آلي لفرق التقريب بأصغر وحدة نقدية',
      );
    }

    return allocatedList;
  }
}
