import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/services/whatsapp_service.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../customers/presentation/cubit/customer_cubit.dart';
import '../../../customers/presentation/cubit/customer_state.dart';
import '../../../wallets/presentation/widgets/record_payment_dialog.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/cubit/settings_state.dart';
import '../../domain/entities/customer_order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';

class OrderDetailSheet extends StatelessWidget {
  final CustomerOrder order;

  const OrderDetailSheet({super.key, required this.order});

  static Future<void> show(BuildContext context, CustomerOrder order) {
    final orderBloc = context.read<OrderBloc>();
    final customerCubit = context.read<CustomerCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: orderBloc),
          BlocProvider.value(value: customerCubit),
        ],
        child: OrderDetailSheet(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lookup customer phone if available
    String customerPhone = '';
    final customerState = context.read<CustomerCubit>().state;
    if (customerState is CustomerLoaded) {
      final cust = customerState.customers.where((c) => c.id == order.customerId).firstOrNull;
      if (cust != null) customerPhone = cust.phone;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space20,
          vertical: AppDimensions.space16,
        ),
        child: SingleChildScrollView(
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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تفاصيل الطلبية ${order.orderNumber}', style: AppTextStyles.headingSmall),
                      Text('العميلة: ${order.customerName}', style: AppTextStyles.subtitleMedium),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space20),
              // Execution & Payment Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('حالة التنفيذ الحالية:', style: AppTextStyles.subtitleMedium),
                  DropdownButton<OrderExecutionStatus>(
                    value: order.executionStatus,
                    underline: const SizedBox.shrink(),
                    borderRadius: AppDimensions.roundedMedium,
                    items: OrderExecutionStatus.values.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(s.labelAr, style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        context.read<OrderBloc>().add(
                              UpdateOrderStatusEvent(orderId: order.id, newStatus: newStatus),
                            );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space12),
              // Items Breakdown
              Text('المنتجات المطلوبة (${order.items.length})', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.space8),
              ...order.items.map((item) {
                final profit = item.itemProfit;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.space8),
                  child: StoreeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.imagePath != null && File(item.imagePath!).existsSync()) ...[
                              ClipRRect(
                                borderRadius: AppDimensions.roundedSmall,
                                child: Image.file(
                                  File(item.imagePath!),
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 52,
                                    height: 52,
                                    color: AppColors.background,
                                    child: const Icon(Icons.broken_image_outlined, color: AppColors.textTertiary),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimensions.space12),
                            ],
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(item.title, style: AppTextStyles.subtitleMedium),
                                      ),
                                      StoreeBadge(
                                        label: '${item.quantity} قطع',
                                        type: BadgeType.primary,
                                      ),
                                    ],
                                  ),
                                  if (item.hasOptionalDetails) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      item.specsDescription,
                                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: AppDimensions.space16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'سعر البيع: ${item.saleUnitPrice.format()} × ${item.quantity}',
                              style: AppTextStyles.bodySmall,
                            ),
                            Text(
                              item.totalSalePrice.format(),
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (item.totalCost != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'التكلفة والشحن: ${item.totalCost!.format()}',
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                              ),
                              if (profit != null)
                                Text(
                                  'الربح: ${profit.format()}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: profit.amountMinor >= 0 ? AppColors.success : AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: AppDimensions.space16),
              // Financial Summary
              StoreeCard(
                backgroundColor: AppColors.secondary,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('إجمالي الطلبية:', style: AppTextStyles.subtitleMedium),
                        Text(order.totalAmount.format(), style: AppTextStyles.moneyMedium),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المدفوع من العميلة:', style: AppTextStyles.subtitleMedium),
                        Text(order.paidAmount.format(), style: AppTextStyles.moneyMedium.copyWith(color: AppColors.success)),
                      ],
                    ),
                    const Divider(height: AppDimensions.space16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المتبقي على العميلة:', style: AppTextStyles.subtitleLarge),
                        Text(
                          order.remainingAmount.format(),
                          style: AppTextStyles.moneyLarge.copyWith(
                            color: order.remainingAmount.isZero ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.space20),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: StoreeButton(
                      label: 'إرسال الفاتورة عبر واتساب',
                      icon: Icons.chat_bubble_outline_rounded,
                      onPressed: () {
                        final settingsState = context.read<SettingsCubit>().state;
                        final storeName = settingsState is SettingsLoaded ? settingsState.profile.storeName : null;
                        final footer = settingsState is SettingsLoaded ? settingsState.profile.customThankYou : null;
                        final invoice = WhatsAppService.formatOrderInvoice(
                          order: order,
                          storeName: storeName,
                          footerMessage: footer,
                        );
                        WhatsAppService.launchWhatsApp(phone: customerPhone, text: invoice);
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.all(AppDimensions.space12),
                    ),
                    tooltip: 'نسخ نص الفاتورة',
                    icon: const Icon(Icons.copy_rounded),
                    onPressed: () {
                      final invoice = WhatsAppService.formatOrderInvoice(order: order);
                      Clipboard.setData(ClipboardData(text: invoice));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم نسخ الفاتورة للحافظة بنجاح'), backgroundColor: AppColors.success),
                      );
                    },
                  ),
                ],
              ),
              if (!order.remainingAmount.isZero) ...[
                const SizedBox(height: AppDimensions.space12),
                StoreeButton(
                  label: 'تسجيل دفعة لهذا الطلب',
                  variant: StoreeButtonVariant.outlined,
                  icon: Icons.payments_outlined,
                  onPressed: () {
                    Navigator.pop(context);
                    RecordPaymentDialog.show(context, preselectedOrder: order);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
