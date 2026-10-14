import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';

class BatchItemAllocated extends Equatable {
  final String orderItemId;
  final String title;
  final int quantity;
  final Money baseCost; // Base price paid to supplier for this item
  final Money allocatedExtraCost; // Share of shipping, customs, and transaction fees
  final String? manualOverrideReason;

  const BatchItemAllocated({
    required this.orderItemId,
    required this.title,
    required this.quantity,
    required this.baseCost,
    required this.allocatedExtraCost,
    this.manualOverrideReason,
  });

  Money get totalCost => baseCost + allocatedExtraCost;

  @override
  List<Object?> get props => [
        orderItemId,
        title,
        quantity,
        baseCost,
        allocatedExtraCost,
        manualOverrideReason,
      ];
}

class PurchaseBatch extends Equatable {
  final String id;
  final String storeName; // e.g. Shein, Zara, Amazon
  final String? invoiceReference;
  final Currency currency;
  final Money extraCosts; // Shipping + handling + customs fees
  final Money discounts; // Store discounts applied to the batch
  final List<BatchItemAllocated> items;
  final DateTime purchasedAt;

  const PurchaseBatch({
    required this.id,
    required this.storeName,
    this.invoiceReference,
    required this.currency,
    required this.extraCosts,
    required this.discounts,
    required this.items,
    required this.purchasedAt,
  });

  Money get totalBaseCost {
    var sum = Money.zero(currency);
    for (final item in items) {
      sum = sum + item.baseCost;
    }
    return sum;
  }

  Money get finalTotalCost => totalBaseCost + extraCosts - discounts;

  @override
  List<Object?> get props => [
        id,
        storeName,
        invoiceReference,
        currency,
        extraCosts,
        discounts,
        items,
        purchasedAt,
      ];
}
