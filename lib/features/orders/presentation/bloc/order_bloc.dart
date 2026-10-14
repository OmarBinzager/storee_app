import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<FilterOrdersByStatusEvent>(_onFilterByStatus);
    on<SearchOrdersEvent>(_onSearchOrders);
    on<AddOrderEvent>(_onAddOrder);
    on<UpdateOrderStatusEvent>(_onUpdateStatus);
  }

  Future<void> _onLoadOrders(LoadOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final result = await repository.getOrders();
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrderLoaded(
        allOrders: orders,
        filteredOrders: orders,
      )),
    );
  }

  void _onFilterByStatus(FilterOrdersByStatusEvent event, Emitter<OrderState> emit) {
    if (state is OrderLoaded) {
      final current = state as OrderLoaded;
      final filtered = _applyFilters(current.allOrders, event.status, current.searchQuery);
      emit(current.copyWith(
        filteredOrders: filtered,
        selectedStatus: event.status,
        clearStatus: event.status == null,
      ));
    }
  }

  void _onSearchOrders(SearchOrdersEvent event, Emitter<OrderState> emit) {
    if (state is OrderLoaded) {
      final current = state as OrderLoaded;
      final filtered = _applyFilters(current.allOrders, current.selectedStatus, event.query);
      emit(current.copyWith(
        filteredOrders: filtered,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onAddOrder(AddOrderEvent event, Emitter<OrderState> emit) async {
    final result = await repository.createOrder(event.order);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (created) {
        if (state is OrderLoaded) {
          final current = state as OrderLoaded;
          final updatedList = [created, ...current.allOrders];
          final filtered = _applyFilters(updatedList, current.selectedStatus, current.searchQuery);
          emit(current.copyWith(
            allOrders: updatedList,
            filteredOrders: filtered,
          ));
        } else {
          add(const LoadOrdersEvent());
        }
      },
    );
  }

  Future<void> _onUpdateStatus(UpdateOrderStatusEvent event, Emitter<OrderState> emit) async {
    final result = await repository.updateOrderStatus(event.orderId, event.newStatus);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) {
        if (state is OrderLoaded) {
          final current = state as OrderLoaded;
          final updatedList = current.allOrders.map((order) {
            if (order.id == event.orderId) {
              return CustomerOrder(
                id: order.id,
                customerId: order.customerId,
                customerName: order.customerName,
                orderNumber: order.orderNumber,
                executionStatus: event.newStatus,
                paymentStatus: order.paymentStatus,
                currency: order.currency,
                items: order.items,
                paidAmount: order.paidAmount,
                discountAmount: order.discountAmount,
                notes: order.notes,
                createdAt: order.createdAt,
                updatedAt: DateTime.now(),
              );
            }
            return order;
          }).toList();

          final filtered = _applyFilters(updatedList, current.selectedStatus, current.searchQuery);
          emit(current.copyWith(allOrders: updatedList, filteredOrders: filtered));
        }
      },
    );
  }

  List<CustomerOrder> _applyFilters(
    List<CustomerOrder> list,
    OrderExecutionStatus? status,
    String query,
  ) {
    return list.where((o) {
      final matchStatus = status == null || o.executionStatus == status;
      final matchQuery = query.isEmpty ||
          o.orderNumber.toLowerCase().contains(query.toLowerCase()) ||
          o.customerName.toLowerCase().contains(query.toLowerCase());
      return matchStatus && matchQuery;
    }).toList();
  }
}
