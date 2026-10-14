import 'package:equatable/equatable.dart';
import '../../../../core/money/money.dart';

class OrderItem extends Equatable {
  final String id;
  final String orderId;
  final String? productId;
  final String title;
  final String? imagePath;
  final String? color;
  final String? size;
  final String? notes; // خامة، مواصفات، ملاحظات اختيارية
  final int quantity;
  final Money saleUnitPrice; // Preserved snapshot of price at order time
  final Money? unitCost; // Recorded when purchased
  final Money? allocatedExtraCost; // Share of batch shipping/customs

  const OrderItem({
    required this.id,
    required this.orderId,
    this.productId,
    required this.title,
    this.imagePath,
    this.color,
    this.size,
    this.notes,
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

  bool get hasOptionalDetails =>
      (size != null && size!.isNotEmpty) ||
      (color != null && color!.isNotEmpty) ||
      (notes != null && notes!.isNotEmpty);

  String get specsDescription {
    final parts = <String>[];
    if (color != null && color!.isNotEmpty) parts.add('اللون: $color');
    if (size != null && size!.isNotEmpty) parts.add('المقاس: $size');
    if (notes != null && notes!.isNotEmpty) parts.add(notes!);
    return parts.join(' • ');
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        title,
        imagePath,
        color,
        size,
        notes,
        quantity,
        saleUnitPrice,
        unitCost,
        allocatedExtraCost,
      ];
}
