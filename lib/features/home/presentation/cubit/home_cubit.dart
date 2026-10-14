import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../orders/domain/repositories/order_repository.dart';
import '../../../reports/domain/repositories/reports_repository.dart';
import '../../../wallets/domain/repositories/wallet_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final OrderRepository orderRepository;
  final WalletRepository walletRepository;
  final ReportsRepository reportsRepository;

  HomeCubit({
    required this.orderRepository,
    required this.walletRepository,
    required this.reportsRepository,
  }) : super(HomeInitial());

  Future<void> loadDashboard() async {
    emit(HomeLoading());

    final walletsResult = await walletRepository.getWallets();
    final ordersResult = await orderRepository.getOrders();
    final reportsResult = await reportsRepository.getAllCurrenciesSummary();

    final wallets = walletsResult.getOrElse(() => []);
    final orders = ordersResult.getOrElse(() => []);
    final reports = reportsResult.getOrElse(() => {});

    // Sort orders descending by createdAt
    final sortedOrders = List<CustomerOrder>.from(orders)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final recentOrders = sortedOrders.take(5).toList();

    int pendingCount = 0;
    int readyCount = 0;

    final Map<String, Money> receivablesByCurrency = {};
    for (final c in Currency.values) {
      receivablesByCurrency[c.code] = Money.zero(c);
    }

    for (final order in orders) {
      if (order.executionStatus != OrderExecutionStatus.delivered &&
          order.executionStatus != OrderExecutionStatus.cancelled) {
        pendingCount++;
      }
      if (order.executionStatus == OrderExecutionStatus.readyToDeliver) {
        readyCount++;
      }

      if (!order.remainingAmount.isZero &&
          order.executionStatus != OrderExecutionStatus.cancelled) {
        final current = receivablesByCurrency[order.currency.code] ?? Money.zero(order.currency);
        receivablesByCurrency[order.currency.code] = current + order.remainingAmount;
      }
    }

    final Map<String, Money> profitsByCurrency = {};
    for (final c in Currency.values) {
      final rep = reports[c.code];
      profitsByCurrency[c.code] = rep?.netProfit ?? Money.zero(c);
    }

    emit(HomeLoaded(
      recentOrders: recentOrders,
      wallets: wallets,
      receivablesByCurrency: receivablesByCurrency,
      profitsByCurrency: profitsByCurrency,
      pendingOrdersCount: pendingCount,
      readyToDeliverCount: readyCount,
    ));
  }
}
