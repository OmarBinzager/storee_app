import 'package:equatable/equatable.dart';
import '../../../../core/money/money.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../wallets/domain/entities/wallet.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CustomerOrder> recentOrders;
  final List<Wallet> wallets;
  final Map<String, Money> receivablesByCurrency; // Customers owe this
  final Map<String, Money> profitsByCurrency; // Net earned profit
  final int pendingOrdersCount;
  final int readyToDeliverCount;

  const HomeLoaded({
    required this.recentOrders,
    required this.wallets,
    required this.receivablesByCurrency,
    required this.profitsByCurrency,
    required this.pendingOrdersCount,
    required this.readyToDeliverCount,
  });

  @override
  List<Object?> get props => [
        recentOrders,
        wallets,
        receivablesByCurrency,
        profitsByCurrency,
        pendingOrdersCount,
        readyToDeliverCount,
      ];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
