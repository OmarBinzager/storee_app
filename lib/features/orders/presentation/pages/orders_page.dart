import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_empty_state.dart';
import '../../domain/entities/customer_order.dart';
import '../../../purchases/presentation/pages/purchases_page.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/add_order_sheet.dart';
import '../widgets/order_detail_sheet.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navOrders),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_shipping_outlined, color: AppColors.textPrimary),
            tooltip: 'فواتير الشراء الجماعي',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PurchasesPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart_rounded, color: AppColors.primary),
            tooltip: 'إنشاء طلبية جديدة',
            onPressed: () => AddOrderSheet.show(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.space16,
              vertical: AppDimensions.space8,
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'بحث برقم الطلب أو اسم العميلة...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              ),
              onChanged: (query) {
                context.read<OrderBloc>().add(SearchOrdersEvent(query));
              },
            ),
          ),
          _buildFilterChips(context),
          const SizedBox(height: AppDimensions.space8),
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is OrderLoaded) {
                  if (state.filteredOrders.isEmpty) {
                    return StoreeEmptyState(
                      title: 'لا توجد طلبات',
                      message: 'لم يتم العثور على أي طلبات تطابق الفلتر أو البحث الحالي. أنشئي طلبية جديدة بالضغط أدناه.',
                      icon: Icons.receipt_long_outlined,
                      actionLabel: 'إنشاء طلبية جديدة',
                      onAction: () => AddOrderSheet.show(context),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.space16,
                      vertical: AppDimensions.space8,
                    ),
                    itemCount: state.filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = state.filteredOrders[index];
                      return _buildOrderCard(context, order);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (prev, curr) => curr is OrderLoaded,
      builder: (context, state) {
        final selected = (state is OrderLoaded) ? state.selectedStatus : null;

        final statuses = [
          null,
          ...OrderExecutionStatus.values,
        ];

        return SizedBox(
          height: 38,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
            scrollDirection: Axis.horizontal,
            itemCount: statuses.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppDimensions.space8),
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected = selected == status;
              final label = status == null ? 'الكل' : status.labelAr;

              return ChoiceChip(
                label: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
                onSelected: (_) {
                  context.read<OrderBloc>().add(FilterOrdersByStatusEvent(status));
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, CustomerOrder order) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space12),
      child: InkWell(
        borderRadius: AppDimensions.roundedMedium,
        onTap: () => OrderDetailSheet.show(context, order),
        child: StoreeCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(order.customerName, style: AppTextStyles.headingSmall),
                      const SizedBox(width: AppDimensions.space8),
                      Text(
                        order.orderNumber,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                PopupMenuButton<OrderExecutionStatus>(
                  tooltip: 'تغيير حالة التنفيذ',
                  onSelected: (newStatus) {
                    context.read<OrderBloc>().add(
                          UpdateOrderStatusEvent(
                            orderId: order.id,
                            newStatus: newStatus,
                          ),
                        );
                  },
                  itemBuilder: (ctx) => OrderExecutionStatus.values.map((s) {
                    return PopupMenuItem(
                      value: s,
                      child: Text(s.labelAr, style: AppTextStyles.bodyMedium),
                    );
                  }).toList(),
                  child: Row(
                    children: [
                      StoreeBadge(
                        label: order.executionStatus.labelAr,
                        type: _getExecutionBadgeType(order.executionStatus),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 18, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: AppDimensions.space20),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x ${item.title}',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(item.totalSalePrice.format(), style: AppTextStyles.bodySmall),
                    ],
                  ),
                )),
            const Divider(height: AppDimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الإجمالي:', style: AppTextStyles.bodySmall),
                    Text(order.totalAmount.format(), style: AppTextStyles.moneyMedium),
                  ],
                ),
                if (!order.remainingAmount.isZero)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('المتبقي على العميلة:', style: AppTextStyles.bodySmall),
                      Text(
                        order.remainingAmount.format(),
                        style: AppTextStyles.moneyMedium.copyWith(color: AppColors.error),
                      ),
                    ],
                  )
                else
                  const StoreeBadge(
                    label: 'مدفوع بالكامل',
                    type: BadgeType.success,
                    icon: Icons.check_circle_outline,
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  BadgeType _getExecutionBadgeType(OrderExecutionStatus status) {
    return switch (status) {
      OrderExecutionStatus.newOrder => BadgeType.info,
      OrderExecutionStatus.confirmed => BadgeType.primary,
      OrderExecutionStatus.purchased => BadgeType.warning,
      OrderExecutionStatus.shipping => BadgeType.warning,
      OrderExecutionStatus.arrived => BadgeType.info,
      OrderExecutionStatus.readyToDeliver => BadgeType.primary,
      OrderExecutionStatus.delivered => BadgeType.success,
      OrderExecutionStatus.cancelled => BadgeType.error,
    };
  }
}
