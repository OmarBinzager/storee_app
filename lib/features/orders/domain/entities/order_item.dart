import 'package:equatable/equatable.dart';
import '../../../../core/money/money.dart';

class OrderItem extends Equatable {
  final String id;
  final String orderId;
  final String? productId;
  final String title;
  final String? color;
  final String? size;
  final int quantity;
  final Money saleUnitPrice; // Preserved snapshot of price at order time
  final Money? unitCost; // Recorded when purchased
  final Money? allocatedExtraCost; // Share of batch shipping/customs

  const OrderItem({
    required this.id,
    required this.orderId,
    this.productId,
    required this.title,
    this.color,
    this.size,
    required this.quantity,
    required this.saleUnitPrice,
    this.unitCost,
    this.allocatedExtraCost,
  });

  Money get totalSalePrice => saleUnitPrice * quantity;

  Money? get totalCost {
    if (unitCost == null) return null;
    final baseCost = unitCost! * quantity;
    if (allocatedExtraCost != null) {
      return baseCost + allocatedExtraCost!;
    }
    return baseCost;
  }

  Money? get itemProfit {
    final cost = totalCost;
    if (cost == null) return null;
    if (cost.currency.code != totalSalePrice.currency.code) return null;
    return totalSalePrice - cost;
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        title,
        color,
        size,
        quantity,
        saleUnitPrice,
        unitCost,
        allocatedExtraCost,
      ];
}
