import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../domain/entities/customer.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  void loadCustomers() {
    emit(CustomerLoading());

    final initialCustomers = [
      Customer(
        id: 'cust-1',
        name: 'فاطمة الكاف',
        phone: '777123456',
        defaultCurrency: Currency.sar,
        notes: 'تفضل التوصيل عصرًا، عميلة منتظمة',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: 'cust-2',
        name: 'منى باوزير',
        phone: '733987654',
        defaultCurrency: Currency.yer,
        notes: 'دفع عبر محفظة جيب كاش',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: 'cust-3',
        name: 'أروى باحميد',
        phone: '711554433',
        defaultCurrency: Currency.sar,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
    ];

    emit(CustomerLoaded(
      customers: initialCustomers,
      filteredCustomers: initialCustomers,
    ));
  }

  void search(String query) {
    if (state is CustomerLoaded) {
      final current = state as CustomerLoaded;
      final filtered = current.customers.where((c) {
        return c.name.toLowerCase().contains(query.toLowerCase()) ||
            c.phone.contains(query);
      }).toList();

      emit(current.copyWith(
        filteredCustomers: filtered,
        searchQuery: query,
      ));
    }
  }

  void addCustomer(Customer customer) {
    if (state is CustomerLoaded) {
      final current = state as CustomerLoaded;
      final updated = [customer, ...current.customers];
      emit(current.copyWith(
        customers: updated,
        filteredCustomers: updated,
      ));
    }
  }
}
