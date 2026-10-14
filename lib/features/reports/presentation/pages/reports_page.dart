import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_card.dart';

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.space16),
        children: [
          _buildCurrencySelector(),
          const SizedBox(height: AppDimensions.space16),
          _buildFinancialSummaryCards(),
          const SizedBox(height: AppDimensions.space20),
          _buildNetProfitCalculationCard(),
          const SizedBox(height: AppDimensions.space20),
          _buildNoticeCard(),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Row(
      children: [
        Text('عرض تقارير عملة:', style: AppTextStyles.subtitleMedium),
        const SizedBox(width: AppDimensions.space12),
        DropdownButton<Currency>(
          value: _selectedCurrency,
          underline: const SizedBox.shrink(),
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
            }
          },
        ),
      ],
    );
  }

  Widget _buildFinancialSummaryCards() {
    final sales = _selectedCurrency == Currency.sar
        ? Money.fromMajor(4500, Currency.sar)
        : Money.fromMajor(1200000, Currency.yer);

    final purchases = _selectedCurrency == Currency.sar
        ? Money.fromMajor(3200, Currency.sar)
        : Money.fromMajor(850000, Currency.yer);

    final shippingFees = _selectedCurrency == Currency.sar
        ? Money.fromMajor(350, Currency.sar)
        : Money.fromMajor(95000, Currency.yer);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: 'إجمالي المبيعات',
                money: sales,
                color: AppColors.primary,
                icon: Icons.point_of_sale_rounded,
              ),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: _buildMetricTile(
                title: 'تكلفة المشتريات',
                money: purchases,
                color: AppColors.textPrimary,
                icon: Icons.inventory_2_outlined,
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
                money: shippingFees,
                color: AppColors.warning,
                icon: Icons.local_shipping_outlined,
              ),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: _buildMetricTile(
                title: 'المصاريف التشغيلية',
                money: _selectedCurrency == Currency.sar
                    ? Money.fromMajor(150, Currency.sar)
                    : Money.fromMajor(40000, Currency.yer),
                color: AppColors.expense,
                icon: Icons.receipt_long_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required Money money,
    required Color color,
    required IconData icon,
  }) {
    return StoreeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(title, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            money.format(),
            style: AppTextStyles.moneyMedium.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildNetProfitCalculationCard() {
    final netProfit = _selectedCurrency == Currency.sar
        ? Money.fromMajor(800, Currency.sar)
        : Money.fromMajor(215000, Currency.yer);

    return StoreeCard(
      backgroundColor: AppColors.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('صافي الربح للفترة', style: AppTextStyles.headingSmall),
              const Icon(Icons.verified_rounded, color: AppColors.primary, size: 22),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'المبيعات − (تكلفة المنتجات + الشحن الموزع + المصاريف التشغيلية)',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.space12),
          Text(
            netProfit.format(),
            style: AppTextStyles.moneyLarge.copyWith(color: AppColors.primaryDark),
          ),
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
              'وفقاً لمعايير ستوري المالية: السحوبات الشخصية والتحويلات الداخلية لا تدرج تلقائياً ضمن تكاليف التشغيل للحفاظ على دقة الأرباح الحقيقية.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
