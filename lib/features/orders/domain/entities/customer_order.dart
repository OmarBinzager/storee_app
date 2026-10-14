import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import 'order_item.dart';

enum OrderExecutionStatus {
  newOrder,
  confirmed,
  purchased,
  shipping,
  arrived,
  readyToDeliver,
  delivered,
  cancelled;

  String get labelAr => switch (this) {
        OrderExecutionStatus.newOrder => 'جديد',
        OrderExecutionStatus.confirmed => 'مؤكد',
        OrderExecutionStatus.purchased => 'تم الشراء',
        OrderExecutionStatus.shipping => 'قيد الشحن',
        OrderExecutionStatus.arrived => 'وصل',
        OrderExecutionStatus.readyToDeliver => 'جاهز للتسليم',
        OrderExecutionStatus.delivered => 'تم التسليم',
        OrderExecutionStatus.cancelled => 'ملغي',
      };
}

enum OrderPaymentStatus {
  unpaid,
  partial,
  paid,
  refunded;

  String get labelAr => switch (this) {
        OrderPaymentStatus.unpaid => 'غير مدفوع',
        OrderPaymentStatus.partial => 'مدفوع جزئياً',
        OrderPaymentStatus.paid => 'مدفوع بالكامل',
        OrderPaymentStatus.refunded => 'مسترد',
      };
}

class CustomerOrder extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String orderNumber;
  final OrderExecutionStatus executionStatus;
  final OrderPaymentStatus paymentStatus;
  final Currency currency;
  final List<OrderItem> items;
  final Money paidAmount;
  final Money discountAmount;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomerOrder({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.orderNumber,
    required this.executionStatus,
    required this.paymentStatus,
    required this.currency,
    required this.items,
    required this.paidAmount,
    required this.discountAmount,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Total sum of items minus discounts
  Money get totalAmount {
    var total = Money.zero(currency);
    for (final item in items) {
      total = total + item.totalSalePrice;
    }
    if (discountAmount.amountMinor > 0) {
      total = total - discountAmount;
    }
    return total;
  }

  /// Remaining unpaid balance
  Money get remainingAmount {
    final diff = totalAmount - paidAmount;
    return diff.isNegative ? Money.zero(currency) : diff;
  }

  /// Overpaid excess balance (credit balance for customer)
  Money get excessCreditAmount {
    final diff = paidAmount - totalAmount;
    return diff.isPositive ? diff : Money.zero(currency);
  }

  /// Whether the profit is estimated or confirmed
  bool get hasAllCostsCalculated {
    return items.isNotEmpty && items.every((item) => item.unitCost != null);
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        orderNumber,
        executionStatus,
        paymentStatus,
        currency,
        items,
        paidAmount,
        discountAmount,
        notes,
        createdAt,
        updatedAt,
      ];
}
