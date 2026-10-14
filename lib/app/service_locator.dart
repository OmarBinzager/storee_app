import 'package:get_it/get_it.dart';
import '../core/database/app_database.dart';
import '../features/backup/data/datasources/backup_local_datasource.dart';
import '../features/backup/data/repositories/backup_repository_impl.dart';
import '../features/backup/domain/repositories/backup_repository.dart';
import '../features/backup/presentation/cubit/backup_cubit.dart';
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
import '../features/purchases/data/datasources/purchase_local_datasource.dart';
import '../features/purchases/data/repositories/purchase_repository_impl.dart';
import '../features/purchases/domain/repositories/purchase_repository.dart';
import '../features/purchases/domain/services/batch_cost_allocator.dart';
import '../features/purchases/presentation/cubit/purchase_cubit.dart';
import '../features/reports/data/datasources/reports_local_datasource.dart';
import '../features/reports/data/repositories/reports_repository_impl.dart';
import '../features/reports/domain/repositories/reports_repository.dart';
import '../features/reports/presentation/cubit/reports_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/licensing/data/datasources/license_local_datasource.dart';
import '../features/licensing/data/repositories/license_repository_impl.dart';
import '../features/licensing/domain/repositories/license_repository.dart';
import '../features/licensing/presentation/cubit/license_cubit.dart';
import '../features/wallets/data/datasources/wallet_local_datasource.dart';
import '../features/wallets/data/repositories/wallet_repository_impl.dart';
import '../features/wallets/domain/repositories/wallet_repository.dart';
import '../features/wallets/presentation/cubit/wallet_cubit.dart';
import '../features/settings/data/repositories/settings_repository_impl.dart';
import '../features/settings/domain/repositories/settings_repository.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({AppDatabase? database, SharedPreferences? preferences}) async {
  // Core Database
  sl.registerLazySingleton<AppDatabase>(() => database ?? AppDatabase());

  // SharedPreferences
  final prefs = preferences ?? await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Data Sources
  sl.registerLazySingleton<CustomerLocalDataSource>(() => CustomerLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<OrderLocalDataSource>(() => OrderLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<WalletLocalDataSource>(() => WalletLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<PurchaseLocalDataSource>(() => PurchaseLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<ReportsLocalDataSource>(() => ReportsLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<BackupLocalDataSource>(() => BackupLocalDataSourceImpl(sl<AppDatabase>()));
  sl.registerLazySingleton<LicenseLocalDataSource>(() => LicenseLocalDataSourceImpl(sl<SharedPreferences>()));

  // Repositories
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl<CustomerLocalDataSource>()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl<OrderLocalDataSource>()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl<WalletLocalDataSource>()));
  sl.registerLazySingleton<PurchaseRepository>(() => PurchaseRepositoryImpl(sl<PurchaseLocalDataSource>()));
  sl.registerLazySingleton<ReportsRepository>(() => ReportsRepositoryImpl(sl<ReportsLocalDataSource>()));
  sl.registerLazySingleton<BackupRepository>(() => BackupRepositoryImpl(sl<BackupLocalDataSource>()));
  sl.registerLazySingleton<LicenseRepository>(() => LicenseRepositoryImpl(sl<LicenseLocalDataSource>()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(sl<SharedPreferences>()));

  // Domain Services
  sl.registerLazySingleton<BatchCostAllocator>(() => const BatchCostAllocator());

  // Blocs & Cubits
  sl.registerFactory<HomeCubit>(() => HomeCubit(
        orderRepository: sl<OrderRepository>(),
        walletRepository: sl<WalletRepository>(),
        reportsRepository: sl<ReportsRepository>(),
      )..loadDashboard());
  sl.registerFactory<OrderBloc>(() => OrderBloc(sl<OrderRepository>())..add(const LoadOrdersEvent()));
  sl.registerFactory<CustomerCubit>(() => CustomerCubit(sl<CustomerRepository>())..loadCustomers());
  sl.registerFactory<WalletCubit>(() => WalletCubit(sl<WalletRepository>())..loadWallets());
  sl.registerFactory<PurchaseCubit>(() => PurchaseCubit(sl<PurchaseRepository>())..loadBatches());
  sl.registerFactory<ReportsCubit>(() => ReportsCubit(sl<ReportsRepository>())..loadReports());
  sl.registerFactory<BackupCubit>(() => BackupCubit(sl<BackupRepository>())..loadBackups());
  sl.registerFactory<LicenseCubit>(() => LicenseCubit(sl<LicenseRepository>())..checkLicense());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(sl<SettingsRepository>())..loadSettings());
}
