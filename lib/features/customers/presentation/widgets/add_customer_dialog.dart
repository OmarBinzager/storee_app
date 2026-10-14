import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../domain/entities/customer.dart';
import '../cubit/customer_cubit.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<CustomerCubit>(),
        child: const AddCustomerDialog(),
      ),
    );
  }

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  Currency _selectedCurrency = Currency.sar;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final newCustomer = Customer(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      defaultCurrency: _selectedCurrency,
      notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final success = await context.read<CustomerCubit>().addCustomer(newCustomer);

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت إضافة العميلة "${newCustomer.name}" بنجاح'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.space20,
        right: AppDimensions.space20,
        top: AppDimensions.space16,
        bottom: AppDimensions.space20 + bottomInset,
      ),
      child: Form(
        key: _formKey,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('إضافة عميلة جديدة', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space24),
              StoreeTextField(
                label: 'اسم العميلة *',
                hint: 'مثال: سارة باوزير',
                controller: _nameController,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'الرجاء إدخال اسم العميلة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.space16),
              StoreeTextField(
                label: 'رقم الهاتف *',
                hint: 'مثال: 777123456',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف للتواصل عبر واتساب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.space16),
              Text('العملة الافتراضية للتعامل', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Currency>(
                    value: _selectedCurrency,
                    isExpanded: true,
                    items: Currency.values.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text('${c.nameAr} (${c.code})', style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (c) {
                      if (c != null) setState(() => _selectedCurrency = c);
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
              StoreeTextField(
                label: 'ملاحظات وتفضيلات التوصيل',
                hint: 'مثال: تفضل التوصيل بعد المغرب، عميلة VIP',
                controller: _notesController,
                maxLines: 2,
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: 'حفظ العميلة',
                icon: Icons.check_rounded,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
