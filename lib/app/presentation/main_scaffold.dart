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

import '../../core/widgets/storee_bottom_nav_bar.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/responsive/responsive_center.dart';
import '../../core/responsive/responsive_modal.dart';

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
    showResponsiveModalSheet(
      context: context,
      maxWidth: 500,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space20,
            vertical: AppDimensions.space16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ModalDragHandle(),
              const SizedBox(height: AppDimensions.space12),
              Text(AppStrings.quickAdd, style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.space16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth < 340 ? 2 : (constraints.maxWidth >= 480 ? 4 : 3);
                  final itemWidth = ((constraints.maxWidth - (cols - 1) * AppDimensions.space12) / cols).floorToDouble();

                  return Wrap(
                    spacing: AppDimensions.space12,
                    runSpacing: AppDimensions.space12,
                    children: [
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.add_shopping_cart_rounded,
                        title: AppStrings.newOrder,
                        color: AppColors.primary,
                        onTap: () {
                          Navigator.pop(ctx);
                          AddOrderSheet.show(context);
                        },
                      ),
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.person_add_outlined,
                        title: AppStrings.newCustomer,
                        color: AppColors.info,
                        onTap: () {
                          Navigator.pop(ctx);
                          AddCustomerDialog.show(context);
                        },
                      ),
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.payments_outlined,
                        title: AppStrings.newPayment,
                        color: AppColors.success,
                        onTap: () {
                          Navigator.pop(ctx);
                          RecordPaymentDialog.show(context);
                        },
                      ),
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.receipt_long_outlined,
                        title: AppStrings.newExpense,
                        color: AppColors.warning,
                        onTap: () {
                          Navigator.pop(ctx);
                          RecordExpenseDialog.show(context);
                        },
                      ),
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.swap_horiz_rounded,
                        title: AppStrings.newTransfer,
                        color: AppColors.primaryLight,
                        onTap: () {
                          Navigator.pop(ctx);
                          TransferFundsDialog.show(context);
                        },
                      ),
                      _buildActionItem(
                        width: itemWidth,
                        icon: Icons.local_shipping_outlined,
                        title: AppStrings.newPurchaseBatch,
                        color: AppColors.primaryDark,
                        onTap: () {
                          Navigator.pop(ctx);
                          CreatePurchaseBatchSheet.show(context);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppDimensions.space16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem({
    required double width,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.roundedMedium,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.space12, horizontal: 4),
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
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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

        final isWide = context.screenWidth >= 720;

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() => _currentIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: AppColors.surface,
                  indicatorColor: AppColors.secondary,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimensions.space16),
                    child: FloatingActionButton.small(
                      onPressed: () => _showQuickAddSheet(context),
                      backgroundColor: AppColors.primary,
                      tooltip: AppStrings.quickAdd,
                      child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
                      label: Text(AppStrings.navHome),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.receipt_long_outlined),
                      selectedIcon: Icon(Icons.receipt_long_rounded, color: AppColors.primary),
                      label: Text(AppStrings.navOrders),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people_outline_rounded),
                      selectedIcon: Icon(Icons.people_rounded, color: AppColors.primary),
                      label: Text(AppStrings.navCustomers),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.account_balance_wallet_outlined),
                      selectedIcon: Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
                      label: Text(AppStrings.navWallets),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart_outlined),
                      selectedIcon: Icon(Icons.bar_chart_rounded, color: AppColors.primary),
                      label: Text(AppStrings.navReports),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
                Expanded(
                  child: ResponsiveCenter(
                    maxWidth: StoreeBreakpoints.maxWideContentWidth,
                    padding: EdgeInsets.zero,
                    child: IndexedStack(
                      index: _currentIndex,
                      children: _pages,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.38),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showQuickAddSheet(context),
                borderRadius: BorderRadius.circular(18),
                child: const SizedBox(
                  width: 52,
                  height: 52,
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: StoreeBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            items: const [
              StoreeNavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: AppStrings.navHome,
              ),
              StoreeNavItem(
                icon: Icons.receipt_long_outlined,
                selectedIcon: Icons.receipt_long_rounded,
                label: AppStrings.navOrders,
              ),
              StoreeNavItem(
                icon: Icons.people_outline_rounded,
                selectedIcon: Icons.people_rounded,
                label: AppStrings.navCustomers,
              ),
              StoreeNavItem(
                icon: Icons.account_balance_wallet_outlined,
                selectedIcon: Icons.account_balance_wallet_rounded,
                label: AppStrings.navWallets,
              ),
              StoreeNavItem(
                icon: Icons.bar_chart_outlined,
                selectedIcon: Icons.bar_chart_rounded,
                label: AppStrings.navReports,
              ),
            ],
          ),
        );
      },
    );
  }
}


