import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(AppStrings.appName, style: AppTextStyles.headingSmall),
            Text(
              AppStrings.appSlogan,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryLight),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async => context.read<HomeCubit>().loadDashboard(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.space16,
                  vertical: AppDimensions.space12,
                ),
                children: [
                  _buildSummaryBanner(context, state),
                  const SizedBox(height: AppDimensions.space20),
                  _buildSectionHeader('المستحقات والأرباح (حسب العملة)'),
                  const SizedBox(height: AppDimensions.space12),
                  _buildCurrencyKpis(state),
                  const SizedBox(height: AppDimensions.space20),
                  _buildSectionHeader('الخزنات النشطة'),
                  const SizedBox(height: AppDimensions.space12),
                  _buildWalletsHorizontalList(state),
                  const SizedBox(height: AppDimensions.space20),
                  _buildSectionHeader('أحدث الطلبيات'),
                  const SizedBox(height: AppDimensions.space12),
                  if (state.recentOrders.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.space16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppDimensions.roundedMedium,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Text(
                          'لا توجد طلبيات بعد. اضغطي (+) لإنشاء أول طلبية.',
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                    )
                  else
                    ...state.recentOrders.map((order) => _buildOrderTile(order)),
                  const SizedBox(height: AppDimensions.space32),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSummaryBanner(BuildContext context, HomeLoaded state) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: AppDimensions.roundedMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المهام العاجلة اليوم',
                style: AppTextStyles.subtitleLarge.copyWith(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppDimensions.roundedSmall,
                ),
                child: Text(
                  '${state.readyToDeliverCount} جاهزة للتسليم',
                  style: AppTextStyles.badgeLabel.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space12),
          Text(
            'لديك ${state.pendingOrdersCount} طلبيات قيد المتابعة والشحن. تأكدي من تتبع وصول الشحنات وتسليم العميلات.',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.9)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.subtitleLarge),
      ],
    );
  }

  Widget _buildCurrencyKpis(HomeLoaded state) {
    return Row(
      children: [
        Expanded(
          child: StoreeCard(
            backgroundColor: AppColors.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.call_received_rounded, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text('مستحقات عند العميلات', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: AppDimensions.space8),
                Text(
                  state.receivablesByCurrency['SAR']?.format() ?? '0 ر.س',
                  style: AppTextStyles.moneyMedium,
                ),
                Text(
                  state.receivablesByCurrency['YER']?.format() ?? '0 ر.ي',
                  style: AppTextStyles.moneyMedium.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.space12),
        Expanded(
          child: StoreeCard(
            backgroundColor: AppColors.successLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.trending_up_rounded, size: 16, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text('أرباح محققة', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: AppDimensions.space8),
                Text(
                  state.profitsByCurrency['SAR']?.format() ?? '0 ر.س',
                  style: AppTextStyles.moneyMedium.copyWith(color: AppColors.success),
                ),
                Text(
                  state.profitsByCurrency['YER']?.format() ?? '0 ر.ي',
                  style: AppTextStyles.moneyMedium.copyWith(
                    color: AppColors.success,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWalletsHorizontalList(HomeLoaded state) {
    if (state.wallets.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppDimensions.space16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimensions.roundedMedium,
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Text(
            'لا توجد خزنات مضافة بعد.',
            style: AppTextStyles.bodySmall,
          ),
        ),
      );
    }

    return SizedBox(
      height: 125,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.wallets.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppDimensions.space12),
        itemBuilder: (context, index) {
          final wallet = state.wallets[index];
          return Container(
            width: 180,
            padding: const EdgeInsets.all(AppDimensions.space12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppDimensions.roundedMedium,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  wallet.name,
                  style: AppTextStyles.subtitleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                ...wallet.balances.values.map(
                  (money) => Text(
                    money.format(),
                    style: AppTextStyles.moneySmall,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderTile(dynamic order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space8),
      child: StoreeCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.space12),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.customerName, style: AppTextStyles.subtitleLarge),
                      Text(order.orderNumber, style: AppTextStyles.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.totalAmount.format(), style: AppTextStyles.moneySmall),
                      StoreeBadge(
                        label: order.executionStatus.labelAr,
                        type: BadgeType.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
