import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/cubit/customer_cubit.dart';
import '../../../customers/presentation/cubit/customer_state.dart';
import '../../../orders/domain/entities/customer_order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../../orders/presentation/bloc/order_state.dart';
import '../../domain/entities/wallet.dart';
import '../cubit/wallet_cubit.dart';
import '../cubit/wallet_state.dart';

class RecordPaymentDialog extends StatefulWidget {
  final Customer? preselectedCustomer;
  final CustomerOrder? preselectedOrder;

  const RecordPaymentDialog({
    super.key,
    this.preselectedCustomer,
    this.preselectedOrder,
  });

  static Future<bool?> show(
    BuildContext context, {
    Customer? preselectedCustomer,
    CustomerOrder? preselectedOrder,
  }) {
    final customerCubit = context.read<CustomerCubit>();
    final orderBloc = context.read<OrderBloc>();
    final walletCubit = context.read<WalletCubit>();
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: customerCubit),
          BlocProvider.value(value: orderBloc),
          BlocProvider.value(value: walletCubit),
        ],
        child: RecordPaymentDialog(
          preselectedCustomer: preselectedCustomer,
          preselectedOrder: preselectedOrder,
        ),
      ),
    );
  }

  @override
  State<RecordPaymentDialog> createState() => _RecordPaymentDialogState();
}

class _RecordPaymentDialogState extends State<RecordPaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  Customer? _selectedCustomer;
  Wallet? _selectedWallet;
  Currency _selectedCurrency = Currency.sar;

  // Selected order to allocate to
  CustomerOrder? _targetOrder;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedCustomer = widget.preselectedCustomer;
    _targetOrder = widget.preselectedOrder;
    if (_targetOrder != null) {
      _selectedCurrency = _targetOrder!.currency;
      _amountController.text = _targetOrder!.remainingAmount.toMajor.toString();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار العميلة أولاً'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار الخزنة المستلمة'), backgroundColor: AppColors.error),
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

    final paymentMoney = Money.fromMajor(amountMajor, _selectedCurrency);

    // Build allocation list if target order is selected
    final allocations = <({String orderId, Money allocatedAmount})>[];
    if (_targetOrder != null) {
      allocations.add((orderId: _targetOrder!.id, allocatedAmount: paymentMoney));
    }

    final success = await context.read<WalletCubit>().recordPayment(
          customerId: _selectedCustomer!.id,
          walletId: _selectedWallet!.id,
          amount: paymentMoney,
          allocations: allocations,
          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        // Refresh orders bloc so unpaid amounts update
        context.read<OrderBloc>().add(const LoadOrdersEvent());
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم استلام دفعة ${paymentMoney.format()} وإيداعها في ${_selectedWallet!.name} بنجاح'),
            backgroundColor: AppColors.success,
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
                  Text('تسجيل دفعة عميلة', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space24),
              // Customer Selection
              _buildCustomerDropdown(),
              const SizedBox(height: AppDimensions.space16),
              // Unpaid Orders of Customer (if any)
              if (_selectedCustomer != null) _buildCustomerOrdersList(),
              const SizedBox(height: AppDimensions.space16),
              // Destination Wallet Selection
              _buildWalletDropdown(),
              const SizedBox(height: AppDimensions.space16),
              // Amount and Currency
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StoreeTextField(
                      label: 'مبلغ الدفعة *',
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
                label: 'ملاحظات / مرجع الإيداع',
                hint: 'مثال: إشعار تحويل الكريمي رقم 9876...',
                controller: _notesController,
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: 'تأكيد وقبض الدفعة',
                icon: Icons.check_circle_outline,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerDropdown() {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        if (state is CustomerLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('العميلة *', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Customer>(
                    hint: const Text('اختاري العميلة...'),
                    value: _selectedCustomer,
                    isExpanded: true,
                    items: state.customers.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text('${c.name} (${c.phone})', style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (c) {
                      if (c != null) {
                        setState(() {
                          _selectedCustomer = c;
                          _selectedCurrency = c.defaultCurrency;
                          _targetOrder = null;
                        });
                      }
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

  Widget _buildCustomerOrdersList() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          final customerUnpaidOrders = state.allOrders.where((o) {
            return o.customerId == _selectedCustomer!.id && !o.remainingAmount.isZero;
          }).toList();

          if (customerUnpaidOrders.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(AppDimensions.space12),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: AppDimensions.roundedMedium,
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                  const SizedBox(width: AppDimensions.space8),
                  Expanded(
                    child: Text(
                      'لا توجد مستحقات معلقة على هذه العميلة. أي دفعة جديدة ستُحفظ كرصيد دائن.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تخصيص الدفعة على طلبية (اختياري)', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              ...customerUnpaidOrders.map((order) {
                final isSelected = _targetOrder?.id == order.id;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.space8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _targetOrder = null;
                        } else {
                          _targetOrder = order;
                          _selectedCurrency = order.currency;
                          _amountController.text = order.remainingAmount.toMajor.toString();
                        }
                      });
                    },
                    borderRadius: AppDimensions.roundedMedium,
                    child: StoreeCard(
                      backgroundColor: isSelected ? AppColors.secondary : AppColors.surface,
                      border: isSelected ? Border.all(color: AppColors.primary, width: 1.5) : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.orderNumber, style: AppTextStyles.subtitleMedium),
                              Text('المتبقي: ${order.remainingAmount.format()}', style: AppTextStyles.moneySmall),
                            ],
                          ),
                          StoreeBadge(
                            label: isSelected ? 'محدد للتخصيص' : 'غير مخصص',
                            type: isSelected ? BadgeType.primary : BadgeType.info,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        }
        return const SizedBox.shrink();
      },
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
              Text('الخزينة / الحساب المستلم *', style: AppTextStyles.subtitleMedium),
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
