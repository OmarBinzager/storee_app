import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';

class FinancialReport extends Equatable {
  final Currency currency;
  final Money totalSales;
  final Money totalCogs; // Cost of goods sold (base unit cost * quantity)
  final Money totalAllocatedShipping; // Allocated shipping & customs fees
  final Money totalOperatingExpenses; // Operating expenses from ledger
  final Money totalPersonalWithdrawals; // Owner personal draws (strictly separate)
  final Money totalCollectedPayments; // Actual cash collected from customers
  final Money totalReceivables; // Remaining debt from customers
  final int totalOrdersCount;
  final int deliveredOrdersCount;

  const FinancialReport({
    required this.currency,
    required this.totalSales,
    required this.totalCogs,
    required this.totalAllocatedShipping,
    required this.totalOperatingExpenses,
    required this.totalPersonalWithdrawals,
    required this.totalCollectedPayments,
    required this.totalReceivables,
    required this.totalOrdersCount,
    required this.deliveredOrdersCount,
  });

  /// Gross Profit = Total Sales - COGS - Allocated Shipping
  Money get grossProfit {
    return totalSales - totalCogs - totalAllocatedShipping;
  }

  /// Net Operating Profit = Gross Profit - Operating Expenses
  Money get netProfit {
    return grossProfit - totalOperatingExpenses;
  }

  @override
  List<Object?> get props => [
        currency,
        totalSales,
        totalCogs,
        totalAllocatedShipping,
        totalOperatingExpenses,
        totalPersonalWithdrawals,
        totalCollectedPayments,
        totalReceivables,
        totalOrdersCount,
        deliveredOrdersCount,
      ];
}
