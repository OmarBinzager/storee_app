import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../domain/entities/wallet.dart';
import '../cubit/wallet_cubit.dart';
import '../cubit/wallet_state.dart';
import '../widgets/add_wallet_dialog.dart';
import '../widgets/record_expense_dialog.dart';
import '../widgets/record_payment_dialog.dart';
import '../widgets/transfer_funds_dialog.dart';

class WalletsPage extends StatelessWidget {
  const WalletsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navWallets),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
            tooltip: 'إضافة خزنة جديدة',
            onPressed: () => AddWalletDialog.show(context),
          ),
        ],
      ),
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WalletLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<WalletCubit>().loadWallets(),
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.space16),
                children: [
                  _buildFinancialActionBar(context),
                  const SizedBox(height: AppDimensions.space20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الخزنات والحسابات', style: AppTextStyles.headingSmall),
                      TextButton.icon(
                        onPressed: () => AddWalletDialog.show(context),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('خزنة جديدة'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  ...state.wallets.map((wallet) => _buildWalletCard(wallet)),
                  const SizedBox(height: AppDimensions.space24),
                  Text('سجل الحركات المالية الأخير', style: AppTextStyles.headingSmall),
                  const SizedBox(height: AppDimensions.space12),
                  if (state.recentTransactions.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.space20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppDimensions.roundedMedium,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Text(
                          'لا توجد حركات مالية مسجلة بعد. عند استلام دفعة أو تسجيل مصروف ستظهر هنا.',
                          style: AppTextStyles.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ...state.recentTransactions.map((tx) => _buildTransactionTile(tx)),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFinancialActionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            label: 'تسجيل دفعة',
            icon: Icons.payments_outlined,
            color: AppColors.success,
            onTap: () => RecordPaymentDialog.show(context),
          ),
        ),
        const SizedBox(width: AppDimensions.space8),
        Expanded(
          child: _buildQuickActionButton(
            label: 'تسجيل مصروف',
            icon: Icons.receipt_long_outlined,
            color: AppColors.warning,
            onTap: () => RecordExpenseDialog.show(context),
          ),
        ),
        const SizedBox(width: AppDimensions.space8),
        Expanded(
          child: _buildQuickActionButton(
            label: 'تحويل داخلي',
            icon: Icons.swap_horiz_rounded,
            color: AppColors.info,
            onTap: () => TransferFundsDialog.show(context),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.roundedMedium,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.space12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: AppDimensions.roundedMedium,
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard(Wallet wallet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space12),
      child: StoreeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      _getWalletIcon(wallet.type),
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Text(wallet.name, style: AppTextStyles.subtitleLarge),
                  ],
                ),
                StoreeBadge(
                  label: wallet.type.labelAr,
                  type: BadgeType.primary,
                ),
              ],
            ),
            const Divider(height: AppDimensions.space20),
            Text('الأرصدة المتوفرة:', style: AppTextStyles.bodySmall),
            const SizedBox(height: AppDimensions.space4),
            Row(
              children: wallet.balances.values
                  .map(
                    (m) => Padding(
                      padding: const EdgeInsets.only(left: AppDimensions.space16),
                      child: Text(
                        m.format(),
                        style: AppTextStyles.moneyMedium,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(FinancialTransaction tx) {
    final (title, icon, color, badgeType) = switch (tx.type) {
      TransactionType.paymentReceived => (
          'دفعة مستلمة من عميلة',
          Icons.arrow_downward_rounded,
          AppColors.success,
          BadgeType.success
        ),
      TransactionType.refundIssued => (
          'استرداد لعميلة',
          Icons.replay_rounded,
          AppColors.error,
          BadgeType.error
        ),
      TransactionType.supplierPayment => (
          'سداد فاتورة مورد',
          Icons.arrow_upward_rounded,
          AppColors.textPrimary,
          BadgeType.info
        ),
      TransactionType.operationalExpense => (
          'مصروف تشغيلي',
          Icons.receipt_outlined,
          AppColors.warning,
          BadgeType.warning
        ),
      TransactionType.personalWithdrawal => (
          'سحب شخصي للمالكة',
          Icons.person_outline_rounded,
          AppColors.textSecondary,
          BadgeType.primary
        ),
      TransactionType.transferIn => (
          'تحويل وارد داخلي',
          Icons.swap_horiz_rounded,
          AppColors.info,
          BadgeType.info
        ),
      TransactionType.transferOut => (
          'تحويل صادر داخلي',
          Icons.swap_horiz_rounded,
          AppColors.info,
          BadgeType.info
        ),
      TransactionType.adjustment => (
          'تسوية رصيد',
          Icons.tune_rounded,
          AppColors.textSecondary,
          BadgeType.primary
        ),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space8),
      child: StoreeCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.space8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.subtitleMedium),
                  if (tx.notes != null)
                    Text(
                      tx.notes!,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tx.amount.format(),
                  style: AppTextStyles.moneySmall.copyWith(
                    color: (tx.type == TransactionType.paymentReceived)
                        ? AppColors.success
                        : AppColors.textPrimary,
                  ),
                ),
                StoreeBadge(
                  label: _formatTransactionTypeBadge(tx.type),
                  type: badgeType,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTransactionTypeBadge(TransactionType type) {
    return switch (type) {
      TransactionType.paymentReceived => 'قبض',
      TransactionType.refundIssued => 'استرداد',
      TransactionType.supplierPayment => 'مورد',
      TransactionType.operationalExpense => 'مصروف',
      TransactionType.personalWithdrawal => 'سحب شخصي',
      TransactionType.transferIn => 'تحويل داخلي',
      TransactionType.transferOut => 'تحويل داخلي',
      TransactionType.adjustment => 'تسوية',
    };
  }

  IconData _getWalletIcon(WalletType type) {
    return switch (type) {
      WalletType.cash => Icons.payments_outlined,
      WalletType.bankAccount => Icons.account_balance_outlined,
      WalletType.electronicWallet => Icons.phone_android_outlined,
      WalletType.custom => Icons.wallet_outlined,
    };
  }
}
