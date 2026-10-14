import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/entities/order_item.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<FilterOrdersByStatusEvent>(_onFilterByStatus);
    on<SearchOrdersEvent>(_onSearchOrders);
    on<AddOrderEvent>(_onAddOrder);
    on<UpdateOrderStatusEvent>(_onUpdateStatus);
  }

  void _onLoadOrders(LoadOrdersEvent event, Emitter<OrderState> emit) {
    emit(OrderLoading());

    final initialOrders = [
      CustomerOrder(
        id: 'ord-101',
        customerId: 'cust-1',
        customerName: 'فاطمة الكاف',
        orderNumber: '#1042',
        executionStatus: OrderExecutionStatus.readyToDeliver,
        paymentStatus: OrderPaymentStatus.partial,
        currency: Currency.sar,
        items: [
          OrderItem(
            id: 'item-1',
            orderId: 'ord-101',
            title: 'فستان مخمل كحلي راقي',
            size: 'L',
            color: 'كحلي',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(180, Currency.sar),
            unitCost: Money.fromMajor(110, Currency.sar),
            allocatedExtraCost: Money.fromMajor(15, Currency.sar),
          ),
        ],
        paidAmount: Money.fromMajor(100, Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      CustomerOrder(
        id: 'ord-102',
        customerId: 'cust-2',
        customerName: 'منى باوزير',
        orderNumber: '#1043',
        executionStatus: OrderExecutionStatus.shipping,
        paymentStatus: OrderPaymentStatus.paid,
        currency: Currency.yer,
        items: [
          OrderItem(
            id: 'item-2',
            orderId: 'ord-102',
            title: 'حقيبة يد جلدية بيج',
            color: 'بيج',
            quantity: 1,
            saleUnitPrice: Money.fromMajor(32000, Currency.yer),
            unitCost: Money.fromMajor(21000, Currency.yer),
            allocatedExtraCost: Money.fromMajor(3000, Currency.yer),
          ),
        ],
        paidAmount: Money.fromMajor(32000, Currency.yer),
        discountAmount: Money.zero(Currency.yer),
        createdAt: DateTime.now().subtract(const Duration(hours: 18)),
        updatedAt: DateTime.now(),
      ),
      CustomerOrder(
        id: 'ord-103',
        customerId: 'cust-3',
        customerName: 'أروى باحميد',
        orderNumber: '#1044',
        executionStatus: OrderExecutionStatus.newOrder,
        paymentStatus: OrderPaymentStatus.unpaid,
        currency: Currency.sar,
        items: [
          OrderItem(
            id: 'item-3',
            orderId: 'ord-103',
            title: 'طقم إكسسوارات لؤلؤ',
            quantity: 2,
            saleUnitPrice: Money.fromMajor(45, Currency.sar),
          ),
        ],
        paidAmount: Money.zero(Currency.sar),
        discountAmount: Money.zero(Currency.sar),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
    ];

    emit(OrderLoaded(
      allOrders: initialOrders,
      filteredOrders: initialOrders,
    ));
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

  void _onAddOrder(AddOrderEvent event, Emitter<OrderState> emit) {
    if (state is OrderLoaded) {
      final current = state as OrderLoaded;
      final updatedList = [event.order, ...current.allOrders];
      final filtered = _applyFilters(updatedList, current.selectedStatus, current.searchQuery);
      emit(current.copyWith(
        allOrders: updatedList,
        filteredOrders: filtered,
      ));
    }
  }

  void _onUpdateStatus(UpdateOrderStatusEvent event, Emitter<OrderState> emit) {
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
