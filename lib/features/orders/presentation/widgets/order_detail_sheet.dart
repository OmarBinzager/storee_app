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
import '../../../wallets/presentation/cubit/wallet_cubit.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/entities/order_item.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../../../purchases/domain/entities/purchase_batch.dart';
import '../../../purchases/presentation/cubit/purchase_cubit.dart';
import '../../../purchases/presentation/cubit/purchase_state.dart';

class OrderDetailSheet extends StatelessWidget {
  final CustomerOrder order;

  const OrderDetailSheet({super.key, required this.order});

  static Future<void> show(BuildContext context, CustomerOrder order) {
    final orderBloc = context.read<OrderBloc>();
    final customerCubit = context.read<CustomerCubit>();
    final walletCubit = context.read<WalletCubit>();
    final purchaseCubit = context.read<PurchaseCubit>();
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
          BlocProvider.value(value: walletCubit),
          BlocProvider.value(value: purchaseCubit),
        ],
        child: OrderDetailSheet(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final currentOrder = (state is OrderLoaded)
            ? (state.allOrders.where((o) => o.id == order.id).firstOrNull ?? order)
            : order;

        // Lookup customer phone if available
        String customerPhone = '';
        final customerState = context.read<CustomerCubit>().state;
        if (customerState is CustomerLoaded) {
          final cust = customerState.customers.where((c) => c.id == currentOrder.customerId).firstOrNull;
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
                      Text('تفاصيل الطلبية ${currentOrder.orderNumber}', style: AppTextStyles.headingSmall),
                      Text('العميلة: ${currentOrder.customerName}', style: AppTextStyles.subtitleMedium),
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
                    value: currentOrder.executionStatus,
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
                              UpdateOrderStatusEvent(orderId: currentOrder.id, newStatus: newStatus),
                            );
                        if (newStatus == OrderExecutionStatus.delivered && !currentOrder.remainingAmount.isZero) {
                          _promptDeliveryPayment(context, currentOrder);
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space8),
              // Courier Quick Transition Banners
              if (currentOrder.executionStatus == OrderExecutionStatus.readyToDeliver) ...[
                Container(
                  padding: const EdgeInsets.all(AppDimensions.space12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: AppDimensions.roundedMedium,
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.success),
                      const SizedBox(width: AppDimensions.space8),
                      Expanded(
                        child: Text(
                          'جميع المنتجات وصلت للمقر وجاهزة للتسليم',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        ),
                        icon: const Icon(Icons.two_wheeler_outlined, size: 16),
                        label: const Text('تسليم للمندوبة', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          context.read<OrderBloc>().add(
                                UpdateOrderStatusEvent(orderId: currentOrder.id, newStatus: OrderExecutionStatus.outForDelivery),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),
              ] else if (currentOrder.executionStatus == OrderExecutionStatus.outForDelivery) ...[
                Container(
                  padding: const EdgeInsets.all(AppDimensions.space12),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: AppDimensions.roundedMedium,
                    border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.delivery_dining_outlined, color: AppColors.warning),
                      const SizedBox(width: AppDimensions.space8),
                      Expanded(
                        child: Text(
                          'الطلبية مع المندوبة للتوصيل للعميلة',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        ),
                        icon: const Icon(Icons.done_all_rounded, size: 16),
                        label: const Text('تم التسليم', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          context.read<OrderBloc>().add(
                                UpdateOrderStatusEvent(orderId: currentOrder.id, newStatus: OrderExecutionStatus.delivered),
                              );
                          if (!currentOrder.remainingAmount.isZero) {
                            _promptDeliveryPayment(context, currentOrder);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),
              ],
              const SizedBox(height: AppDimensions.space12),
              // Items Breakdown
              Text('المنتجات المطلوبة (${currentOrder.items.length})', style: AppTextStyles.headingSmall),
              const SizedBox(height: AppDimensions.space8),
              ...currentOrder.items.map((item) {
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
                                  const SizedBox(height: 4),
                                  _buildItemTrackingBadge(context, item),
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
                        Text(currentOrder.totalAmount.format(), style: AppTextStyles.moneyMedium),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المدفوع من العميلة:', style: AppTextStyles.subtitleMedium),
                        Text(currentOrder.paidAmount.format(), style: AppTextStyles.moneyMedium.copyWith(color: AppColors.success)),
                      ],
                    ),
                    const Divider(height: AppDimensions.space16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المتبقي على العميلة:', style: AppTextStyles.subtitleLarge),
                        Text(
                          currentOrder.remainingAmount.format(),
                          style: AppTextStyles.moneyLarge.copyWith(
                            color: currentOrder.remainingAmount.isZero ? AppColors.success : AppColors.error,
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
                          order: currentOrder,
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
                      final invoice = WhatsAppService.formatOrderInvoice(order: currentOrder);
                      Clipboard.setData(ClipboardData(text: invoice));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم نسخ الفاتورة للحافظة بنجاح'), backgroundColor: AppColors.success),
                      );
                    },
                  ),
                ],
              ),
              if (!currentOrder.remainingAmount.isZero) ...[
                const SizedBox(height: AppDimensions.space12),
                StoreeButton(
                  label: 'تسجيل دفعة لهذا الطلب',
                  variant: StoreeButtonVariant.outlined,
                  icon: Icons.payments_outlined,
                  onPressed: () {
                    final cust = (customerState is CustomerLoaded)
                        ? customerState.customers.where((c) => c.id == currentOrder.customerId).firstOrNull
                        : null;
                    RecordPaymentDialog.show(
                      context,
                      preselectedCustomer: cust,
                      preselectedOrder: currentOrder,
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildItemTrackingBadge(BuildContext context, OrderItem item) {
    if (item.unitCost == null) {
      return const StoreeBadge(
        label: '⏳ بانتظار الشراء',
        type: BadgeType.info,
      );
    }

    final purchaseState = context.watch<PurchaseCubit>().state;
    if (purchaseState is PurchaseLoaded) {
      final batch = purchaseState.batches.where(
        (b) => b.items.any((bi) => bi.orderItemId == item.id),
      ).firstOrNull;

      if (batch != null) {
        switch (batch.status) {
          case PurchaseBatchStatus.purchased:
            return const StoreeBadge(label: '🛍️ تم الشراء من الموقع', type: BadgeType.primary);
          case PurchaseBatchStatus.shipping:
            return const StoreeBadge(label: '✈️ قيد الشحن الدولي', type: BadgeType.warning);
          case PurchaseBatchStatus.arrived:
            return const StoreeBadge(label: '📦 وصل للمقر', type: BadgeType.success);
          case PurchaseBatchStatus.cancelled:
            return const StoreeBadge(label: '❌ ملغي من المورد', type: BadgeType.error);
        }
      }
    }

    return const StoreeBadge(
      label: '🛍️ تم الشراء',
      type: BadgeType.primary,
    );
  }

  void _promptDeliveryPayment(BuildContext context, CustomerOrder order) {
    final customerState = context.read<CustomerCubit>().state;
    final cust = (customerState is CustomerLoaded)
        ? customerState.customers.where((c) => c.id == order.customerId).firstOrNull
        : null;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('تحصيل الدفعة عند الاستلام (COD)'),
        content: Text(
          'تم تأكيد تسليم الطلبية!\n\nيوجد مبلغ متبقي على العميلة قدره (${order.remainingAmount.format()}).\nهل قامت العميلة بسداده للمندوبة (كاش أو بنك) وترغبين بتسجيل الدفعة الآن؟',
        ),
        actions: [
          TextButton(
            child: const Text('تأكيد التسليم فقط (آجل)'),
            onPressed: () => Navigator.pop(dialogCtx),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('تسجيل الدفعة الآن'),
            onPressed: () {
              Navigator.pop(dialogCtx);
              RecordPaymentDialog.show(
                context,
                preselectedCustomer: cust,
                preselectedOrder: order,
              );
            },
          ),
        ],
      ),
    );
  }
}

