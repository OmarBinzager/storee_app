import '../../../../core/database/app_database.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/financial_report.dart';

abstract class ReportsLocalDataSource {
  Future<FinancialReport> getFinancialReport({
    required Currency currency,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<Map<String, FinancialReport>> getAllCurrenciesSummary();
}

class ReportsLocalDataSourceImpl implements ReportsLocalDataSource {
  final AppDatabase database;

  ReportsLocalDataSourceImpl(this.database);

  @override
  Future<FinancialReport> getFinancialReport({
    required Currency currency,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    // 1. Fetch non-cancelled orders for currency
    final allOrders = await database.select(database.customerOrdersTable).get();
    final filteredOrders = allOrders.where((o) {
      if (o.currencyCode != currency.code) return false;
      if (o.executionStatus == 'cancelled') return false;
      if (fromDate != null && o.createdAt.isBefore(fromDate)) return false;
      if (toDate != null && o.createdAt.isAfter(toDate)) return false;
      return true;
    }).toList();

    int totalSalesMinor = 0;
    int totalCogsMinor = 0;
    int totalAllocatedShippingMinor = 0;
    int totalReceivablesMinor = 0;
    int deliveredOrdersCount = 0;

    for (final order in filteredOrders) {
      if (order.executionStatus == 'delivered') {
        deliveredOrdersCount++;
      }

      // Fetch order items
      final items = await (database.select(database.orderItemsTable)
            ..where((t) => t.orderId.equals(order.id)))
          .get();

      int orderItemsSaleTotal = 0;
      for (final item in items) {
        orderItemsSaleTotal += item.saleUnitPriceMinor * item.quantity;
        if (item.unitCostMinor != null) {
          totalCogsMinor += item.unitCostMinor! * item.quantity;
        }
        if (item.allocatedExtraCostMinor != null) {
          totalAllocatedShippingMinor += item.allocatedExtraCostMinor!;
        }
      }

      final orderTotal = orderItemsSaleTotal - order.discountAmountMinor;
      totalSalesMinor += orderTotal;

      final remaining = orderTotal - order.paidAmountMinor;
      if (remaining > 0) {
        totalReceivablesMinor += remaining;
      }
    }

    // 2. Fetch financial transactions for this currency
    final allTransactions = await database.select(database.financialTransactionsTable).get();
    final filteredTransactions = allTransactions.where((t) {
      if (t.currencyCode != currency.code) return false;
      if (fromDate != null && t.occurredAt.isBefore(fromDate)) return false;
      if (toDate != null && t.occurredAt.isAfter(toDate)) return false;
      return true;
    }).toList();

    int totalOperatingExpensesMinor = 0;
    int totalPersonalWithdrawalsMinor = 0;
    int totalCollectedPaymentsMinor = 0;

    for (final tx in filteredTransactions) {
      if (tx.type == 'operationalExpense' || tx.type == 'expense') {
        totalOperatingExpensesMinor += tx.amountMinor;
      } else if (tx.type == 'personalWithdrawal') {
        totalPersonalWithdrawalsMinor += tx.amountMinor;
      } else if (tx.type == 'paymentReceived' || tx.type == 'customerPayment') {
        totalCollectedPaymentsMinor += tx.amountMinor;
      }
    }

    return FinancialReport(
      currency: currency,
      totalSales: Money(amountMinor: totalSalesMinor, currency: currency),
      totalCogs: Money(amountMinor: totalCogsMinor, currency: currency),
      totalAllocatedShipping: Money(amountMinor: totalAllocatedShippingMinor, currency: currency),
      totalOperatingExpenses: Money(amountMinor: totalOperatingExpensesMinor, currency: currency),
      totalPersonalWithdrawals: Money(amountMinor: totalPersonalWithdrawalsMinor, currency: currency),
      totalCollectedPayments: Money(amountMinor: totalCollectedPaymentsMinor, currency: currency),
      totalReceivables: Money(amountMinor: totalReceivablesMinor, currency: currency),
      totalOrdersCount: filteredOrders.length,
      deliveredOrdersCount: deliveredOrdersCount,
    );
  }

  @override
  Future<Map<String, FinancialReport>> getAllCurrenciesSummary() async {
    final Map<String, FinancialReport> summaries = {};
    for (final curr in Currency.values) {
      final report = await getFinancialReport(currency: curr);
      summaries[curr.code] = report;
    }
    return summaries;
  }
}
