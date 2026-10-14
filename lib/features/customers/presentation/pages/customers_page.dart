import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_empty_state.dart';
import '../../domain/entities/customer.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';
import '../widgets/add_customer_dialog.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navCustomers),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded, color: AppColors.primary),
            tooltip: 'إضافة عميلة',
            onPressed: () => AddCustomerDialog.show(context),
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
                hintText: 'بحث باسم العميلة أو رقم الهاتف...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              ),
              onChanged: (query) {
                context.read<CustomerCubit>().search(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CustomerCubit, CustomerState>(
              builder: (context, state) {
                if (state is CustomerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CustomerLoaded) {
                  if (state.filteredCustomers.isEmpty) {
                    return StoreeEmptyState(
                      title: 'لا توجد عميلات',
                      message: 'لم يتم العثور على أي عميلة تطابق البحث. اضغطي الزر لإضافة عميلة جديدة.',
                      icon: Icons.person_search_outlined,
                      actionLabel: 'إضافة عميلة جديدة',
                      onAction: () => AddCustomerDialog.show(context),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.space16,
                      vertical: AppDimensions.space8,
                    ),
                    itemCount: state.filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = state.filteredCustomers[index];
                      return _buildCustomerCard(context, customer);
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

  Widget _buildCustomerCard(BuildContext context, Customer customer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space12),
      child: StoreeCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.secondary,
              child: Text(
                customer.name.isNotEmpty ? customer.name[0] : 'ع',
                style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(customer.name, style: AppTextStyles.subtitleLarge),
                      StoreeBadge(
                        label: customer.defaultCurrency.nameAr,
                        type: BadgeType.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(customer.phone, style: AppTextStyles.bodySmall),
                    ],
                  ),
                  if (customer.notes != null && customer.notes!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      customer.notes!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
