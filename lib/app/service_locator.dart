import 'package:get_it/get_it.dart';
import '../features/customers/presentation/cubit/customer_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/orders/presentation/bloc/order_bloc.dart';
import '../features/orders/presentation/bloc/order_event.dart';
import '../features/purchases/domain/services/batch_cost_allocator.dart';
import '../features/wallets/presentation/cubit/wallet_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Domain Services
  sl.registerLazySingleton<BatchCostAllocator>(() => const BatchCostAllocator());

  // Blocs & Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit()..loadDashboard());
  sl.registerFactory<OrderBloc>(() => OrderBloc()..add(const LoadOrdersEvent()));
  sl.registerFactory<CustomerCubit>(() => CustomerCubit()..loadCustomers());
  sl.registerFactory<WalletCubit>(() => WalletCubit()..loadWallets());
}
