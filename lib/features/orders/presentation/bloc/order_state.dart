import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_order.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<CustomerOrder> allOrders;
  final List<CustomerOrder> filteredOrders;
  final OrderExecutionStatus? selectedStatus;
  final String searchQuery;

  const OrderLoaded({
    required this.allOrders,
    required this.filteredOrders,
    this.selectedStatus,
    this.searchQuery = '',
  });

  OrderLoaded copyWith({
    List<CustomerOrder>? allOrders,
    List<CustomerOrder>? filteredOrders,
    OrderExecutionStatus? selectedStatus,
    bool clearStatus = false,
    String? searchQuery,
  }) {
    return OrderLoaded(
      allOrders: allOrders ?? this.allOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      selectedStatus: clearStatus ? null : (selectedStatus ?? this.selectedStatus),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [allOrders, filteredOrders, selectedStatus, searchQuery];
}

class OrderError extends OrderState {
  final String message;
  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}
