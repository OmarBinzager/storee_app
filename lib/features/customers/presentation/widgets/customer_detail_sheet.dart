import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/money/money.dart';
import '../../../../core/services/whatsapp_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../domain/entities/customer.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_state.dart';
import '../../../orders/presentation/widgets/add_order_sheet.dart';
import '../../../orders/presentation/widgets/order_detail_sheet.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';

class CustomerDetailSheet extends StatelessWidget {
  final Customer customer;

  const CustomerDetailSheet({super.key, required this.customer});

  static void show(BuildContext context, Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<OrderBloc>(),
        child: CustomerDetailSheet(customer: customer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            List<CustomerOrder> customerOrders = [];
            if (state is OrderLoaded) {
              customerOrders = state.allOrders.where((o) => o.customerId == customer.id).toList();
            }

            Money totalOrdersValue = Money.zero(customer.defaultCurrency);
            Money totalPaidValue = Money.zero(customer.defaultCurrency);
            Money totalRemainingValue = Money.zero(customer.defaultCurrency);

            for (final order in customerOrders) {
              if (order.totalAmount.currency == customer.defaultCurrency) {
                totalOrdersValue = totalOrdersValue + order.totalAmount;
                totalPaidValue = totalPaidValue + order.paidAmount;
                totalRemainingValue = totalRemainingValue + order.remainingAmount;
              }
            }

            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space20,
                vertical: AppDimensions.space16,
              ),
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

                // Customer Header Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.secondary,
                      child: Text(
                        customer.name.isNotEmpty ? customer.name[0] : 'ع',
                        style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(customer.name, style: AppTextStyles.headingSmall),
                              StoreeBadge(
                                label: customer.defaultCurrency.nameAr,
                                type: BadgeType.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(customer.phone, style: AppTextStyles.bodyMedium),
                          if (customer.notes != null && customer.notes!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              customer.notes!,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space16),

                // Action Buttons (WhatsApp, Call, Add Order)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.success,
                          side: const BorderSide(color: AppColors.success),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedMedium),
                        ),
                        icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                        label: const Text('واتساب'),
                        onPressed: () => WhatsAppService.launchWhatsApp(phone: customer.phone),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedMedium),
                        ),
                        icon: const Icon(Icons.phone_in_talk_outlined, size: 18),
                        label: const Text('اتصال'),
                        onPressed: () => WhatsAppService.makePhoneCall(customer.phone),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedMedium),
                        ),
                        icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                        label: const Text('طلب جديد'),
                        onPressed: () {
                          Navigator.pop(context);
                          AddOrderSheet.show(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(borderRadius: AppDimensions.roundedMedium),
                    ),
                    icon: const Icon(Icons.receipt_outlined, size: 18, color: AppColors.primary),
                    label: const Text('مشاركة كشف الحساب عبر واتساب'),
                    onPressed: () {
                      final settingsState = context.read<SettingsCubit>().state;
                      final storeName = settingsState is SettingsLoaded ? settingsState.profile.storeName : null;
                      final footer = settingsState is SettingsLoaded ? settingsState.profile.customThankYou : null;
                      final statement = WhatsAppService.formatCustomerStatement(
                        customer: customer,
                        orders: customerOrders,
                        storeName: storeName,
                        footerMessage: footer,
                      );
                      WhatsAppService.launchWhatsApp(phone: customer.phone, text: statement);
                    },
                  ),
                ),
                const SizedBox(height: AppDimensions.space20),

                // Financial Overview Cards
                Text('الملخص المالي للعميلة', style: AppTextStyles.subtitleLarge),
                const SizedBox(height: AppDimensions.space8),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'إجمالي المشتريات',
                        amount: totalOrdersValue.format(),
                        color: AppColors.textPrimary,
                        bgColor: AppColors.surface,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: _buildStatCard(
                        title: 'المدفوع',
                        amount: totalPaidValue.format(),
                        color: AppColors.success,
                        bgColor: AppColors.success.withValues(alpha: 0.08),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: _buildStatCard(
                        title: 'المتبقي (دين)',
                        amount: totalRemainingValue.format(),
                        color: totalRemainingValue.amountMinor > 0 ? AppColors.error : AppColors.textSecondary,
                        bgColor: totalRemainingValue.amountMinor > 0
                            ? AppColors.error.withValues(alpha: 0.08)
                            : AppColors.surface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space24),

                // Orders List
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سجل الطلبيات (${customerOrders.length})',
                      style: AppTextStyles.subtitleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space8),

                if (customerOrders.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.space24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppDimensions.roundedMedium,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.shopping_bag_outlined, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.5)),
                          const SizedBox(height: 8),
                          Text(
                            'لا توجد طلبيات مسجلة لهذه العميلة بعد',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...customerOrders.map((order) => _buildOrderTile(context, order)),

                const SizedBox(height: AppDimensions.space24),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String amount,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(title, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              amount,
              style: AppTextStyles.subtitleLarge.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTile(BuildContext context, CustomerOrder order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space8),
      child: StoreeCard(
        onTap: () {
          OrderDetailSheet.show(context, order);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'طلبية #${order.orderNumber}',
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    _buildExecutionBadge(order.executionStatus),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${order.items.length} منتج • ${_formatDate(order.createdAt)}',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  order.totalAmount.format(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                _buildPaymentBadge(order.paymentStatus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutionBadge(OrderExecutionStatus status) {
    switch (status) {
      case OrderExecutionStatus.newOrder:
        return StoreeBadge(label: status.labelAr, type: BadgeType.info);
      case OrderExecutionStatus.confirmed:
        return StoreeBadge(label: status.labelAr, type: BadgeType.primary);
      case OrderExecutionStatus.purchased:
        return StoreeBadge(label: status.labelAr, type: BadgeType.info);
      case OrderExecutionStatus.shipping:
        return StoreeBadge(label: status.labelAr, type: BadgeType.warning);
      case OrderExecutionStatus.arrived:
        return StoreeBadge(label: status.labelAr, type: BadgeType.info);
      case OrderExecutionStatus.readyToDeliver:
        return StoreeBadge(label: status.labelAr, type: BadgeType.warning);
      case OrderExecutionStatus.delivered:
        return StoreeBadge(label: status.labelAr, type: BadgeType.success);
      case OrderExecutionStatus.cancelled:
        return StoreeBadge(label: status.labelAr, type: BadgeType.error);
    }
  }

  Widget _buildPaymentBadge(OrderPaymentStatus status) {
    switch (status) {
      case OrderPaymentStatus.unpaid:
        return StoreeBadge(label: status.labelAr, type: BadgeType.error);
      case OrderPaymentStatus.partial:
        return StoreeBadge(label: status.labelAr, type: BadgeType.warning);
      case OrderPaymentStatus.paid:
        return StoreeBadge(label: status.labelAr, type: BadgeType.success);
      case OrderPaymentStatus.refunded:
        return StoreeBadge(label: status.labelAr, type: BadgeType.info);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
