import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRepository repository;

  CustomerCubit(this.repository) : super(CustomerInitial());

  Future<void> loadCustomers() async {
    emit(CustomerLoading());

    final result = await repository.getCustomers();
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomerLoaded(
        customers: customers,
        filteredCustomers: customers,
      )),
    );
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

  Future<bool> addCustomer(Customer customer) async {
    final result = await repository.addCustomer(customer);
    return result.fold(
      (failure) {
        emit(CustomerError(failure.message));
        return false;
      },
      (created) {
        if (state is CustomerLoaded) {
          final current = state as CustomerLoaded;
          final updated = [created, ...current.customers];
          emit(current.copyWith(
            customers: updated,
            filteredCustomers: updated,
          ));
        } else {
          loadCustomers();
        }
        return true;
      },
    );
  }
}
