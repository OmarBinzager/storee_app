import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../domain/entities/wallet.dart';
import '../cubit/wallet_cubit.dart';

class AddWalletDialog extends StatefulWidget {
  const AddWalletDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<WalletCubit>(),
        child: const AddWalletDialog(),
      ),
    );
  }

  @override
  State<AddWalletDialog> createState() => _AddWalletDialogState();
}

class _AddWalletDialogState extends State<AddWalletDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  WalletType _selectedType = WalletType.bankAccount;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final success = await context.read<WalletCubit>().createWallet(
          name: _nameController.text.trim(),
          type: _selectedType,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إنشاء الخزنة "${_nameController.text.trim()}" بنجاح'),
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
                  Text('إضافة خزينة / حساب جديد', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space24),
              StoreeTextField(
                label: 'اسم الخزينة أو الحساب *',
                hint: 'مثال: حساب بنك الكريمي، محفظة ون كاش',
                controller: _nameController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
              ),
              const SizedBox(height: AppDimensions.space16),
              Text('نوع الحساب', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<WalletType>(
                    value: _selectedType,
                    isExpanded: true,
                    items: WalletType.values.map((t) {
                      return DropdownMenuItem(
                        value: t,
                        child: Text(t.labelAr, style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (t) {
                      if (t != null) setState(() => _selectedType = t);
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: 'حفظ الخزينة',
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
