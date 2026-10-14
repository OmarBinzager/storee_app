import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_empty_state.dart';
import '../../../customers/presentation/cubit/customer_cubit.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../../purchases/presentation/cubit/purchase_cubit.dart';
import '../../../reports/presentation/cubit/reports_cubit.dart';
import '../../../wallets/presentation/cubit/wallet_cubit.dart';
import '../../domain/entities/backup_metadata.dart';
import '../cubit/backup_cubit.dart';
import '../cubit/backup_state.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النسخ الاحتياطي والاستعادة'),
      ),
      body: BlocConsumer<BackupCubit, BackupState>(
        listener: (context, state) {
          if (state is BackupActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
            );
          } else if (state is BackupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is BackupLoading;
          final backups = (state is BackupLoaded) ? state.backups : <BackupMetadata>[];

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.space16),
            children: [
              _buildSecurityNoticeCard(),
              const SizedBox(height: AppDimensions.space16),
              StoreeButton(
                label: 'إنشاء نسخة احتياطية جديدة الآن',
                icon: Icons.cloud_upload_outlined,
                isLoading: isLoading,
                onPressed: () => context.read<BackupCubit>().createBackup(),
              ),
              const SizedBox(height: AppDimensions.space24),
              Text('النسخ المحفوظة على هذا الجهاز', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.space8),
              if (backups.isEmpty && !isLoading)
                StoreeEmptyState(
                  title: 'لا توجد نسخ احتياطية محفوظة',
                  message: 'أنشئي نسخة احتياطية لحماية بياناتك والطلبات وحسابات الخزنات بأمان.',
                  icon: Icons.backup_outlined,
                  actionLabel: 'إنشاء نسخة الآن',
                  onAction: () => context.read<BackupCubit>().createBackup(),
                )
              else
                ...backups.map((meta) => _buildBackupItem(context, meta, isLoading)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSecurityNoticeCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_outlined, color: AppColors.primary, size: 24),
              const SizedBox(width: AppDimensions.space8),
              Text('حماية كاملة دون إنترنت (Offline Safe)', style: AppTextStyles.subtitleLarge),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'تتضمن النسخة الاحتياطية جميع العميلات، الطلبيات، أرصدة الخزنات، فواتير الشراء الجماعي وسجل الحركات المالية مع بصمة تحقق رقمية (SHA-256) تمنع التلاعب وتضمن دقة الاستعادة بنسبة 100%.',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupItem(BuildContext context, BackupMetadata meta, bool isLoading) {
    final sizeKb = (meta.payloadSizeBytes / 1024).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space12),
      child: StoreeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.archive_outlined, color: AppColors.primary, size: 22),
                      const SizedBox(width: AppDimensions.space8),
                      Expanded(
                        child: Text(
                          meta.fileName,
                          style: AppTextStyles.subtitleMedium.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                StoreeBadge(
                  label: '$sizeKb KB',
                  type: BadgeType.info,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space8),
            Text(
              'تاريخ الإنشاء: ${_formatDateTime(meta.createdAt)}',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const Divider(height: AppDimensions.space16),
            Wrap(
              spacing: AppDimensions.space16,
              runSpacing: 4,
              children: [
                Text('العميلات: ${meta.customerCount}', style: AppTextStyles.bodySmall),
                Text('الطلبات: ${meta.orderCount}', style: AppTextStyles.bodySmall),
                Text('الخزنات: ${meta.walletCount}', style: AppTextStyles.bodySmall),
                Text('الشراء الجماعي: ${meta.purchaseBatchCount}', style: AppTextStyles.bodySmall),
              ],
            ),
            const SizedBox(height: AppDimensions.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.restore_rounded, size: 18),
                  label: const Text('استعادة هذه النسخة'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  onPressed: isLoading ? null : () => _confirmAndRestore(context, meta),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmAndRestore(BuildContext context, BackupMetadata meta) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد استعادة النسخة'),
        content: Text(
          'تنبيه: سيتم استبدال البيانات الحالية على هذا الجهاز بالبيانات الموجودة في النسخة الاحتياطية (${meta.fileName}). هل تودين الاستمرار؟',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('نعم، استعادة الآن', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await context.read<BackupCubit>().restoreBackup(meta.filePath);
      if (success && context.mounted) {
        // Refresh all feature providers to sync the UI with restored database
        context.read<OrderBloc>().add(const LoadOrdersEvent());
        context.read<CustomerCubit>().loadCustomers();
        context.read<WalletCubit>().loadWallets();
        context.read<PurchaseCubit>().loadBatches();
        context.read<ReportsCubit>().loadReports();
        context.read<HomeCubit>().loadDashboard();
      }
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
