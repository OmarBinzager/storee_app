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

class TransferFundsDialog extends StatefulWidget {
  const TransferFundsDialog({super.key});

  static Future<bool?> show(BuildContext context) {
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
        child: const TransferFundsDialog(),
      ),
    );
  }

  @override
  State<TransferFundsDialog> createState() => _TransferFundsDialogState();
}

class _TransferFundsDialogState extends State<TransferFundsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _sourceWalletId;
  String? _destinationWalletId;
  Currency _selectedCurrency = Currency.sar;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_sourceWalletId == null || _destinationWalletId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار خزينة الإرسال والاستقبال'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_sourceWalletId == _destinationWalletId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن التحويل لنفس الخزنة، يرجى اختيار خزنتين مختلفتين'), backgroundColor: AppColors.error),
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

    final success = await context.read<WalletCubit>().recordTransfer(
          fromWalletId: _sourceWalletId!,
          toWalletId: _destinationWalletId!,
          amount: money,
          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم التحويل الداخلي بنجاح بقيمة ${money.format()}'),
            backgroundColor: AppColors.info,
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
                  Text('تحويل بين الخزنات', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space24),
              // Storee Financial Rule Notice
              Container(
                padding: const EdgeInsets.all(AppDimensions.space12),
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, color: AppColors.info, size: 20),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: Text(
                        'قاعدة ستوري: التحويل الداخلي بين الخزنات لا يعد دخلاً أو مصروفاً، ولا يغير صافي أرباح المتجر إطلاقاً.',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
              // Source and Destination Wallets
              _buildWalletsSelectors(),
              const SizedBox(height: AppDimensions.space16),
              // Amount and Currency
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StoreeTextField(
                      label: 'المبلغ المحوّل *',
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
                label: 'ملاحظات التحويل',
                hint: 'مثال: إيداع نقدي في حساب الكريمي...',
                controller: _notesController,
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: 'تأكيد التحويل الداخلي',
                icon: Icons.swap_horiz_rounded,
                isLoading: _isSubmitting,
                color: AppColors.info,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletsSelectors() {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded) {
          final wallets = state.wallets;
          if ((_sourceWalletId == null || !wallets.any((w) => w.id == _sourceWalletId)) && wallets.isNotEmpty) {
            _sourceWalletId = wallets.first.id;
          }
          if ((_destinationWalletId == null || !wallets.any((w) => w.id == _destinationWalletId)) && wallets.length > 1) {
            _destinationWalletId = wallets[1].id;
          }

          return Column(
            children: [
              _buildSingleWalletDropdown('من خزنة (المصدر) *', _sourceWalletId, wallets, (id) {
                setState(() => _sourceWalletId = id);
              }),
              const SizedBox(height: AppDimensions.space12),
              _buildSingleWalletDropdown('إلى خزنة (المستلم) *', _destinationWalletId, wallets, (id) {
                setState(() => _destinationWalletId = id);
              }),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSingleWalletDropdown(
    String label,
    String? currentId,
    List<Wallet> wallets,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.subtitleMedium),
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
              value: currentId,
              isExpanded: true,
              items: wallets.map((w) {
                return DropdownMenuItem<String>(
                  value: w.id,
                  child: Text('${w.name} (${w.type.labelAr})', style: AppTextStyles.bodyMedium),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
