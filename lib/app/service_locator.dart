import 'package:get_it/get_it.dart';
import '../core/database/app_database.dart';
import '../features/customers/data/datasources/customer_local_datasource.dart';
import '../features/customers/data/repositories/customer_repository_impl.dart';
import '../features/customers/domain/repositories/customer_repository.dart';
import '../features/customers/presentation/cubit/customer_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/orders/data/datasources/order_local_datasource.dart';
import '../features/orders/data/repositories/order_repository_impl.dart';
import '../features/orders/domain/repositories/order_repository.dart';
import '../features/orders/presentation/bloc/order_bloc.dart';
import '../features/orders/presentation/bloc/order_event.dart';
import '../features/purchases/domain/services/batch_cost_allocator.dart';
import '../features/wallets/data/datasources/wallet_local_datasource.dart';
import '../features/wallets/data/repositories/wallet_repository_impl.dart';
import '../features/wallets/domain/repositories/wallet_repository.dart';
import '../features/wallets/presentation/cubit/wallet_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({AppDatabase? database}) async {
  // Core Database
  sl.registerLazySingleton<AppDatabase>(() => database ?? AppDatabase());

  // Data Sources
  sl.registerLazySingleton<CustomerLocalDataSource>(() => CustomerLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<OrderLocalDataSource>(() => OrderLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<WalletLocalDataSource>(() => WalletLocalDataSourceImpl(sl<AppDatabase>()));

  // Repositories
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl<CustomerLocalDataSource>()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl<OrderLocalDataSource>()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl<WalletLocalDataSource>()));

  // Domain Services
  sl.registerLazySingleton<BatchCostAllocator>(() => const BatchCostAllocator());

  // Blocs & Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit()..loadDashboard());
  sl.registerFactory<OrderBloc>(() => OrderBloc(sl<OrderRepository>())..add(const LoadOrdersEvent()));
  sl.registerFactory<CustomerCubit>(() => CustomerCubit(sl<CustomerRepository>())..loadCustomers());
  sl.registerFactory<WalletCubit>(() => WalletCubit(sl<WalletRepository>())..loadWallets());
}
