import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../domain/entities/financial_report.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  Currency _selectedCurrency = Currency.sar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navReports),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'تحديث التقارير',
            onPressed: () => context.read<ReportsCubit>().loadReports(currency: _selectedCurrency),
          ),
        ],
      ),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ReportsError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
              ),
            );
          }

          if (state is ReportsLoaded) {
            final report = state.currentReport;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ReportsCubit>().loadReports(currency: _selectedCurrency);
              },
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.space16),
                children: [
                  _buildCurrencySelector(state.selectedCurrency),
                  const SizedBox(height: AppDimensions.space16),
                  _buildNetProfitCalculationCard(report),
                  const SizedBox(height: AppDimensions.space16),
                  _buildFinancialSummaryCards(report),
                  const SizedBox(height: AppDimensions.space16),
                  _buildCashFlowAndReceivablesCards(report),
                  const SizedBox(height: AppDimensions.space20),
                  _buildNoticeCard(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCurrencySelector(Currency selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16, vertical: AppDimensions.space8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('عرض أرقام عملة:', style: AppTextStyles.subtitleMedium),
          DropdownButtonHideUnderline(
            child: DropdownButton<Currency>(
              value: selected,
              borderRadius: AppDimensions.roundedMedium,
              items: Currency.values.map((curr) {
                return DropdownMenuItem(
                  value: curr,
                  child: Text('${curr.nameAr} (${curr.code})', style: AppTextStyles.bodyMedium),
                );
              }).toList(),
              onChanged: (curr) {
                if (curr != null) {
                  setState(() => _selectedCurrency = curr);
                  context.read<ReportsCubit>().switchCurrency(curr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummaryCards(FinancialReport report) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: 'إجمالي المبيعات',
                money: report.totalSales,
                color: AppColors.primary,
                icon: Icons.point_of_sale_rounded,
                subtitle: '${report.totalOrdersCount} طلبات (${report.deliveredOrdersCount} مسلّمة)',
              ),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: _buildMetricTile(
                title: 'تكلفة البضاعة (COGS)',
                money: report.totalCogs,
                color: AppColors.textPrimary,
                icon: Icons.inventory_2_outlined,
                subtitle: 'تكلفة الشراء المباشرة',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.space12),
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: 'الشحن والجمارك',
                money: report.totalAllocatedShipping,
                color: AppColors.warning,
                icon: Icons.local_shipping_outlined,
                subtitle: 'الموزعة على الدفعات',
              ),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: _buildMetricTile(
                title: 'المصاريف التشغيلية',
                money: report.totalOperatingExpenses,
                color: AppColors.expense,
                icon: Icons.receipt_long_outlined,
                subtitle: 'تغليف، رصيد، إعلانات...',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCashFlowAndReceivablesCards(FinancialReport report) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(
            title: 'المقبوض فعلياً',
            money: report.totalCollectedPayments,
            color: AppColors.success,
            icon: Icons.payments_outlined,
            subtitle: 'المحصّل في الخزنات',
          ),
        ),
        const SizedBox(width: AppDimensions.space12),
        Expanded(
          child: _buildMetricTile(
            title: 'ديون عند العميلات',
            money: report.totalReceivables,
            color: report.totalReceivables.isZero ? AppColors.textSecondary : AppColors.error,
            icon: Icons.pending_actions_rounded,
            subtitle: 'متبقي على ذمة الطلبات',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required Money money,
    required Color color,
    required IconData icon,
    String? subtitle,
  }) {
    return StoreeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            money.format(),
            style: AppTextStyles.moneyMedium.copyWith(color: color),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNetProfitCalculationCard(FinancialReport report) {
    final isProfitable = report.netProfit.amountMinor >= 0;

    return StoreeCard(
      backgroundColor: isProfitable ? AppColors.secondary : AppColors.surface,
      border: Border.all(
        color: isProfitable ? AppColors.primaryLight : AppColors.error.withValues(alpha: 0.5),
        width: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('صافي الربح الحقيقي للفترة', style: AppTextStyles.headingSmall),
              Icon(
                isProfitable ? Icons.verified_rounded : Icons.warning_amber_rounded,
                color: isProfitable ? AppColors.primary : AppColors.error,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'المبيعات − (تكلفة المنتجات + الشحن الموزع + المصاريف التشغيلية)',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.space12),
          Text(
            report.netProfit.format(),
            style: AppTextStyles.moneyLarge.copyWith(
              color: isProfitable ? AppColors.primaryDark : AppColors.error,
            ),
          ),
          if (!report.totalPersonalWithdrawals.isZero) ...[
            const Divider(height: AppDimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سحوبات شخصية للمالك (منفصلة):',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
                Text(
                  report.totalPersonalWithdrawals.format(),
                  style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoticeCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space12),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.info, size: 20),
          const SizedBox(width: AppDimensions.space8),
          Expanded(
            child: Text(
              'وفقاً لقواعد ستوري المحاسبية الصارمة: تحصيل دفعة العميلة لا يعني ربحاً فورياً، والتحويلات بين الخزنات ليست دخلاً أو مصروفاً، وسحوبات المالك الشخصية معزولة تماماً عن تكاليف التشغيل.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
