import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../features/customers/presentation/cubit/customer_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/orders/presentation/bloc/order_bloc.dart';
import '../features/purchases/presentation/cubit/purchase_cubit.dart';
import '../features/reports/presentation/cubit/reports_cubit.dart';
import '../features/wallets/presentation/cubit/wallet_cubit.dart';
import 'router/app_router.dart';
import 'service_locator.dart';

class StoreeApp extends StatelessWidget {
  const StoreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => sl<HomeCubit>(),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => sl<OrderBloc>(),
        ),
        BlocProvider<CustomerCubit>(
          create: (_) => sl<CustomerCubit>(),
        ),
        BlocProvider<WalletCubit>(
          create: (_) => sl<WalletCubit>(),
        ),
        BlocProvider<PurchaseCubit>(
          create: (_) => sl<PurchaseCubit>(),
        ),
        BlocProvider<ReportsCubit>(
          create: (_) => sl<ReportsCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        locale: const Locale('ar', 'YE'),
        supportedLocales: const [
          Locale('ar', 'YE'),
          Locale('ar', 'SA'),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
