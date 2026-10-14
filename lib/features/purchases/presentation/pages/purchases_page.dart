import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_empty_state.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../domain/entities/purchase_batch.dart';
import '../cubit/purchase_cubit.dart';
import '../cubit/purchase_state.dart';
import '../widgets/create_purchase_batch_sheet.dart';

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فواتير الشراء الجماعي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart_rounded, color: AppColors.primary),
            tooltip: 'فاتورة شراء جديدة',
            onPressed: () => CreatePurchaseBatchSheet.show(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => CreatePurchaseBatchSheet.show(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'شراء جماعي جديد',
          style: AppTextStyles.buttonLabel.copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<PurchaseCubit, PurchaseState>(
        builder: (context, state) {
          if (state is PurchaseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PurchaseError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
              ),
            );
          }

          if (state is PurchaseLoaded) {
            if (state.batches.isEmpty) {
              return StoreeEmptyState(
                title: 'لا توجد فواتير شراء جماعي',
                message: 'لم يتم تسجيل أي فواتير شراء بعد. يمكنك تجميع طلبات العميلات وشراؤها وتوزيع تكاليف الشحن بدقة.',
                icon: Icons.local_shipping_outlined,
                actionLabel: 'تسجيل شراء جماعي',
                onAction: () => CreatePurchaseBatchSheet.show(context),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space16,
                vertical: AppDimensions.space12,
              ),
              itemCount: state.batches.length,
              itemBuilder: (context, index) {
                final batch = state.batches[index];
                return _buildBatchCard(context, batch);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  BadgeType _badgeTypeForStatus(PurchaseBatchStatus status) {
    switch (status) {
      case PurchaseBatchStatus.purchased:
        return BadgeType.primary;
      case PurchaseBatchStatus.shipping:
        return BadgeType.warning;
      case PurchaseBatchStatus.arrived:
        return BadgeType.success;
      case PurchaseBatchStatus.cancelled:
        return BadgeType.error;
    }
  }

  Widget _buildBatchCard(BuildContext context, PurchaseBatch batch) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space12),
      child: StoreeCard(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(top: AppDimensions.space8),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.space8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: AppDimensions.roundedMedium,
                        ),
                        child: const Icon(Icons.storefront_outlined, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: AppDimensions.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(batch.storeName, style: AppTextStyles.headingSmall, overflow: TextOverflow.ellipsis),
                            if (batch.invoiceReference != null)
                              Text(
                                batch.invoiceReference!,
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoreeBadge(
                      label: batch.status.labelAr,
                      type: _badgeTypeForStatus(batch.status),
                    ),
                    PopupMenuButton<PurchaseBatchStatus>(
                      icon: const Icon(Icons.more_vert_rounded, size: 20, color: AppColors.textSecondary),
                      tooltip: 'تغيير حالة الشحنة',
                      onSelected: (newStatus) async {
                        final success = await context.read<PurchaseCubit>().updateBatchStatus(batch.id, newStatus);
                        if (success && context.mounted) {
                          context.read<OrderBloc>().add(const LoadOrdersEvent());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم تحديث الشحنة إلى (${newStatus.labelAr}) وتحديث طلبيات العميلات آلياً'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => PurchaseBatchStatus.values.map((s) {
                        return PopupMenuItem(
                          value: s,
                          child: Row(
                            children: [
                              Icon(
                                s == batch.status ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                                color: s == batch.status ? AppColors.primary : AppColors.textTertiary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(s.labelAr, style: AppTextStyles.bodyMedium),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: AppDimensions.space8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${batch.items.length} منتجات • ',
                        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        _formatDate(batch.purchasedAt),
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  Text(
                    batch.finalTotalCost.format(),
                    style: AppTextStyles.moneyMedium,
                  ),
                ],
              ),
            ),
            children: [
              const Divider(color: AppColors.border),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('سعر القطع الأساسي:', style: AppTextStyles.bodySmall),
                  Text(batch.totalBaseCost.format(), style: AppTextStyles.bodySmall),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('تكاليف الشحن والجمارك الموزعة:', style: AppTextStyles.bodySmall),
                  Text(batch.extraCosts.format(), style: AppTextStyles.bodySmall),
                ],
              ),
              if (!batch.discounts.isZero) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الخصومات المستفادة:', style: AppTextStyles.bodySmall.copyWith(color: AppColors.success)),
                    Text('- ${batch.discounts.format()}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.success)),
                  ],
                ),
              ],
              const Divider(color: AppColors.border),
              Align(
                alignment: Alignment.centerRight,
                child: Text('تفاصيل المنتجات وتوزيع التكلفة:', style: AppTextStyles.subtitleMedium),
              ),
              const SizedBox(height: AppDimensions.space8),
              ...batch.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.space8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.5),
                        borderRadius: AppDimensions.roundedSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                Text('الكمية: ${item.quantity}', style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('التكلفة: ${item.totalCost.format()}', style: AppTextStyles.bodyMedium),
                              Text('(شحن: ${item.allocatedExtraCost.format()})', style: AppTextStyles.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
