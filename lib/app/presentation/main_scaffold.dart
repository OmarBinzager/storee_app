import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../features/security/presentation/cubit/security_cubit.dart';
import '../../features/security/presentation/cubit/security_state.dart';
import '../../features/security/presentation/pages/pin_lock_page.dart';
import '../../core/theme/text_styles.dart';
import '../../features/customers/presentation/pages/customers_page.dart';
import '../../features/customers/presentation/widgets/add_customer_dialog.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/orders/presentation/widgets/add_order_sheet.dart';
import '../../features/purchases/presentation/widgets/create_purchase_batch_sheet.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/wallets/presentation/pages/wallets_page.dart';
import '../../features/wallets/presentation/widgets/record_expense_dialog.dart';
import '../../features/wallets/presentation/widgets/record_payment_dialog.dart';
import '../../features/wallets/presentation/widgets/transfer_funds_dialog.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    OrdersPage(),
    CustomersPage(),
    WalletsPage(),
    ReportsPage(),
  ];

  void _showQuickAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.space20,
              vertical: AppDimensions.space16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: AppDimensions.roundedPill,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.space16),
                Text(AppStrings.quickAdd, style: AppTextStyles.headingSmall),
                const SizedBox(height: AppDimensions.space16),
                Wrap(
                  spacing: AppDimensions.space12,
                  runSpacing: AppDimensions.space12,
                  children: [
                    _buildActionItem(
                      icon: Icons.add_shopping_cart_rounded,
                      title: AppStrings.newOrder,
                      color: AppColors.primary,
                      onTap: () {
                        Navigator.pop(ctx);
                        AddOrderSheet.show(context);
                      },
                    ),
                    _buildActionItem(
                      icon: Icons.person_add_outlined,
                      title: AppStrings.newCustomer,
                      color: AppColors.info,
                      onTap: () {
                        Navigator.pop(ctx);
                        AddCustomerDialog.show(context);
                      },
                    ),
                    _buildActionItem(
                      icon: Icons.payments_outlined,
                      title: AppStrings.newPayment,
                      color: AppColors.success,
                      onTap: () {
                        Navigator.pop(ctx);
                        RecordPaymentDialog.show(context);
                      },
                    ),
                    _buildActionItem(
                      icon: Icons.receipt_long_outlined,
                      title: AppStrings.newExpense,
                      color: AppColors.warning,
                      onTap: () {
                        Navigator.pop(ctx);
                        RecordExpenseDialog.show(context);
                      },
                    ),
                    _buildActionItem(
                      icon: Icons.swap_horiz_rounded,
                      title: AppStrings.newTransfer,
                      color: AppColors.primaryLight,
                      onTap: () {
                        Navigator.pop(ctx);
                        TransferFundsDialog.show(context);
                      },
                    ),
                    _buildActionItem(
                      icon: Icons.local_shipping_outlined,
                      title: AppStrings.newPurchaseBatch,
                      color: AppColors.primaryDark,
                      onTap: () {
                        Navigator.pop(ctx);
                        CreatePurchaseBatchSheet.show(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.roundedMedium,
      child: Container(
        width: 105,
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.space12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppDimensions.roundedMedium,
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, securityState) {
        if (securityState is SecurityLocked) {
          return const PinLockPage();
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showQuickAddSheet(context),
            tooltip: AppStrings.quickAdd,
            child: const Icon(Icons.add_rounded, size: 28),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: AppStrings.navHome,
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long_rounded),
                label: AppStrings.navOrders,
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(Icons.people_rounded),
                label: AppStrings.navCustomers,
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: AppStrings.navWallets,
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart_rounded),
                label: AppStrings.navReports,
              ),
            ],
          ),
        );
      },
    );
  }
}
