import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';
import 'package:storee/features/purchases/domain/services/batch_cost_allocator.dart';

void main() {
  group('BatchCostAllocator Tests', () {
    const allocator = BatchCostAllocator();

    test('matches Storee App Specification document example exactly (60, 40 + 10 shipping -> 66, 44)', () {
      final items = [
        (
          orderItemId: 'item-1',
          title: 'فستان مخمل',
          quantity: 1,
          baseCost: Money.fromMajor(60, Currency.sar),
        ),
        (
          orderItemId: 'item-2',
          title: 'حقيبة يد',
          quantity: 1,
          baseCost: Money.fromMajor(40, Currency.sar),
        ),
      ];

      final shipping = Money.fromMajor(10, Currency.sar);
      final discount = Money.zero(Currency.sar);

      final allocated = allocator.allocate(
        rawItems: items,
        extraCosts: shipping,
        discounts: discount,
      );

      expect(allocated.length, 2);

      // Item 1: 60 SAR base + 6 SAR allocated = 66 SAR total
      expect(allocated[0].allocatedExtraCost.toMajor, 6.0);
      expect(allocated[0].totalCost.toMajor, 66.0);

      // Item 2: 40 SAR base + 4 SAR allocated = 44 SAR total
      expect(allocated[1].allocatedExtraCost.toMajor, 4.0);
      expect(allocated[1].totalCost.toMajor, 44.0);

      // Total sum must be exactly 110 SAR
      final totalAllocatedCost = allocated.fold(
        Money.zero(Currency.sar),
        (sum, item) => sum + item.totalCost,
      );
      expect(totalAllocatedCost.toMajor, 110.0);
    });
  });
}
