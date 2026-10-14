import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../domain/entities/wallet.dart';
import '../cubit/wallet_cubit.dart';
import '../cubit/wallet_state.dart';

class RecordExpenseDialog extends StatefulWidget {
  final bool initialIsPersonalWithdrawal;

  const RecordExpenseDialog({
    super.key,
    this.initialIsPersonalWithdrawal = false,
  });

  static Future<bool?> show(BuildContext context, {bool isPersonalWithdrawal = false}) {
    final walletCubit = context.read<WalletCubit>();
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => BlocProvider.value(
        value: walletCubit,
        child: RecordExpenseDialog(initialIsPersonalWithdrawal: isPersonalWithdrawal),
      ),
    );
  }

  @override
  State<RecordExpenseDialog> createState() => _RecordExpenseDialogState();
}

class _RecordExpenseDialogState extends State<RecordExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  late bool _isPersonalWithdrawal;
  Wallet? _selectedWallet;
  Currency _selectedCurrency = Currency.sar;
  String _selectedCategory = 'تغليف وهدايا';

  final List<String> _categories = [
    'تغليف وهدايا',
    'شحن ونقل وتوصيل',
    'اتصالات ورصيد إنترنت',
    'رسوم تحويل وعمولات بنكية',
    'إعلانات وتسويق',
    'أدوات مكتبية ومستلزمات',
    'أخرى',
  ];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _isPersonalWithdrawal = widget.initialIsPersonalWithdrawal;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار الخزنة المصروف منها'), backgroundColor: AppColors.error),
      );
      return;
    }

    final amountMajor = double.tryParse(_amountController.text) ?? 0.0;
    if (amountMajor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('المبلغ يجب أن يكون أكبر من الصفر'), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final money = Money.fromMajor(amountMajor, _selectedCurrency);

    bool success;
    if (_isPersonalWithdrawal) {
      success = await context.read<WalletCubit>().recordPersonalWithdrawal(
            walletId: _selectedWallet!.id,
            amount: money,
            notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
          );
    } else {
      success = await context.read<WalletCubit>().recordExpense(
            walletId: _selectedWallet!.id,
            amount: money,
            category: _selectedCategory,
            notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
          );
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isPersonalWithdrawal
                  ? 'تم تسجيل السحب الشخصي للمالكة بقيمة ${money.format()}'
                  : 'تم تسجيل المصروف التشغيلي ($_selectedCategory) بقيمة ${money.format()}',
            ),
            backgroundColor: _isPersonalWithdrawal ? AppColors.primary : AppColors.warning,
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
                  Text(
                    _isPersonalWithdrawal ? 'سحب شخصي للمالكة' : 'تسجيل مصروف تشغيلي',
                    style: AppTextStyles.headingSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space12),
              // Type Toggle
              _buildTypeToggle(),
              const Divider(height: AppDimensions.space24),
              // Wallet Selection
              _buildWalletDropdown(),
              const SizedBox(height: AppDimensions.space16),
              // Category (only for operational expense)
              if (!_isPersonalWithdrawal) ...[
                Text('تصنيف المصروف', style: AppTextStyles.subtitleMedium),
                const SizedBox(height: AppDimensions.space8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppDimensions.roundedMedium,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      items: _categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat, style: AppTextStyles.bodyMedium));
                      }).toList(),
                      onChanged: (cat) {
                        if (cat != null) setState(() => _selectedCategory = cat);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.space16),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(AppDimensions.space12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: AppDimensions.roundedMedium,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
                      const SizedBox(width: AppDimensions.space8),
                      Expanded(
                        child: Text(
                          'معيار ستوري: السحب الشخصي للمالكة يُعزل تماماً عن المصاريف التشغيلية ولا يُحسب خسارة على المتجر.',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.space16),
              ],
              // Amount and Currency
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StoreeTextField(
                      label: 'المبلغ *',
                      hint: '0.0',
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('العملة', style: AppTextStyles.subtitleMedium),
                        const SizedBox(height: AppDimensions.space8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space12),
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
                                  child: Text(c.code, style: AppTextStyles.bodyMedium),
                                );
                              }).toList(),
                              onChanged: (c) {
                                if (c != null) setState(() => _selectedCurrency = c);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space16),
              StoreeTextField(
                label: 'ملاحظات وتفاصيل',
                hint: 'تفاصيل الشراء أو الإيصال...',
                controller: _notesController,
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: _isPersonalWithdrawal ? 'تأكيد السحب الشخصي' : 'تسجيل المصروف',
                icon: Icons.check_rounded,
                isLoading: _isSubmitting,
                color: _isPersonalWithdrawal ? AppColors.primary : AppColors.warning,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeToggle() {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Center(child: Text('مصروف تشغيلي')),
            selected: !_isPersonalWithdrawal,
            selectedColor: AppColors.warningLight,
            onSelected: (val) {
              if (val) setState(() => _isPersonalWithdrawal = false);
            },
          ),
        ),
        const SizedBox(width: AppDimensions.space8),
        Expanded(
          child: ChoiceChip(
            label: const Center(child: Text('سحب شخصي للمالكة')),
            selected: _isPersonalWithdrawal,
            selectedColor: AppColors.secondary,
            onSelected: (val) {
              if (val) setState(() => _isPersonalWithdrawal = true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWalletDropdown() {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded) {
          if (_selectedWallet == null && state.wallets.isNotEmpty) {
            _selectedWallet = state.wallets.first;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الصرف من خزينة *', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Wallet>(
                    value: _selectedWallet,
                    isExpanded: true,
                    items: state.wallets.map((w) {
                      return DropdownMenuItem(
                        value: w,
                        child: Text('${w.name} (${w.type.labelAr})', style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (w) {
                      if (w != null) setState(() => _selectedWallet = w);
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
