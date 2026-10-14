import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_order.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrdersEvent extends OrderEvent {
  const LoadOrdersEvent();
}

class FilterOrdersByStatusEvent extends OrderEvent {
  final OrderExecutionStatus? status;
  const FilterOrdersByStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class SearchOrdersEvent extends OrderEvent {
  final String query;
  const SearchOrdersEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class AddOrderEvent extends OrderEvent {
  final CustomerOrder order;
  const AddOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}

class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final OrderExecutionStatus newStatus;

  const UpdateOrderStatusEvent({
    required this.orderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [orderId, newStatus];
}
