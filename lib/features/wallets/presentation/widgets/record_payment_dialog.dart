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
  final _orderDeductionController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedCustomerId;
  String? _selectedWalletId;
  Currency _selectedCurrency = Currency.sar;

  // Selected order to allocate to (null if auto-allocate or general credit)
  CustomerOrder? _targetOrder;
  bool _autoAllocateFifo = true;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedCustomer != null) {
      _selectedCustomerId = widget.preselectedCustomer!.id;
      _selectedCurrency = widget.preselectedCustomer!.defaultCurrency;
    }

    if (widget.preselectedOrder != null) {
      _targetOrder = widget.preselectedOrder;
      _selectedCustomerId ??= widget.preselectedOrder!.customerId;
      _selectedCurrency = widget.preselectedOrder!.currency;
      _autoAllocateFifo = false;
      _amountController.text = widget.preselectedOrder!.remainingAmount.toMajor.toString();
      _orderDeductionController.text = widget.preselectedOrder!.remainingAmount.toMajor.toString();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _orderDeductionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isCrossCurrency =>
      _targetOrder != null && _selectedCurrency != _targetOrder!.currency;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCustomerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار العميلة أولاً'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_selectedWalletId == null) {
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

    final paymentMoney = Money.fromMajor(amountMajor, _selectedCurrency);

    // Build allocation list
    final allocations = <({String orderId, Money allocatedAmount})>[];

    if (_targetOrder != null) {
      if (_isCrossCurrency) {
        final deductionMajor = double.tryParse(_orderDeductionController.text) ?? 0.0;
        if (deductionMajor <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('الرجاء تحديد المبلغ المخصوم من الطلب بعملة ${_targetOrder!.currency.nameAr}'),
              backgroundColor: AppColors.error,
            ),
          );
          return;
        }
        final deductionMoney = Money.fromMajor(deductionMajor, _targetOrder!.currency);
        allocations.add((orderId: _targetOrder!.id, allocatedAmount: deductionMoney));
      } else {
        // Same currency allocation
        final deductionMoney = Money.fromMajor(amountMajor, _targetOrder!.currency);
        allocations.add((orderId: _targetOrder!.id, allocatedAmount: deductionMoney));
      }
    } else if (_autoAllocateFifo) {
      // FIFO allocation across unpaid orders of this customer matching payment currency
      final orderState = context.read<OrderBloc>().state;
      if (orderState is OrderLoaded) {
        final customerUnpaidOrders = orderState.allOrders
            .where((o) =>
                o.customerId == _selectedCustomerId &&
                o.currency == _selectedCurrency &&
                !o.remainingAmount.isZero)
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt)); // FIFO: oldest first

        var remainingToAllocateMinor = paymentMoney.amountMinor;
        for (final ord in customerUnpaidOrders) {
          if (remainingToAllocateMinor <= 0) break;
          final neededMinor = ord.remainingAmount.amountMinor;
          final allocatedMinor = remainingToAllocateMinor >= neededMinor ? neededMinor : remainingToAllocateMinor;

          allocations.add((
            orderId: ord.id,
            allocatedAmount: Money(amountMinor: allocatedMinor, currency: _selectedCurrency),
          ));
          remainingToAllocateMinor -= allocatedMinor;
        }
      }
    }

    setState(() => _isSubmitting = true);

    final success = await context.read<WalletCubit>().recordPayment(
          customerId: _selectedCustomerId!,
          walletId: _selectedWalletId!,
          amount: paymentMoney,
          allocations: allocations,
          notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        // Refresh all blocs so orders, customer balances, and wallets update immediately
        context.read<OrderBloc>().add(const LoadOrdersEvent());
        context.read<CustomerCubit>().loadCustomers();
        context.read<WalletCubit>().loadWallets();

        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              allocations.isNotEmpty
                  ? 'تم استلام الدفعة ${paymentMoney.format()} وتخصيصها بنجاح'
                  : 'تم استلام الدفعة ${paymentMoney.format()} وحفظها كرصيد دائن للعميلة',
            ),
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
              if (_selectedCustomerId != null) _buildCustomerOrdersList(),
              const SizedBox(height: AppDimensions.space16),
              // Destination Wallet Selection
              _buildWalletDropdown(),
              const SizedBox(height: AppDimensions.space16),
              // Amount and Currency received
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: StoreeTextField(
                      label: 'المبلغ المستلم *',
                      hint: '0.0',
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                      onChanged: (_) {
                        if (!_isCrossCurrency && _targetOrder != null) {
                          _orderDeductionController.text = _amountController.text;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('عملة الدفعة', style: AppTextStyles.subtitleMedium),
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
                                if (c != null) {
                                  setState(() {
                                    _selectedCurrency = c;
                                    if (!_isCrossCurrency && _targetOrder != null) {
                                      _orderDeductionController.text = _amountController.text;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Cross-currency conversion box if payment currency != target order currency
              if (_isCrossCurrency) ...[
                const SizedBox(height: AppDimensions.space16),
                _buildCrossCurrencyConversionCard(),
              ],
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

  Widget _buildCrossCurrencyConversionCard() {
    final paymentVal = double.tryParse(_amountController.text) ?? 0.0;
    final orderVal = double.tryParse(_orderDeductionController.text) ?? 0.0;
    String? rateHint;
    if (paymentVal > 0 && orderVal > 0) {
      final rate = (paymentVal / orderVal).toStringAsFixed(2);
      rateHint = 'سعر الصرف المحتسب: 1 ${_targetOrder!.currency.code} = $rate ${_selectedCurrency.code}';
    }

    return Container(
      padding: const EdgeInsets.all(AppDimensions.space12),
      decoration: BoxDecoration(
        color: AppColors.warningLight.withValues(alpha: 0.5),
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.currency_exchange_rounded, color: AppColors.warning, size: 20),
              const SizedBox(width: AppDimensions.space8),
              Expanded(
                child: Text(
                  'دفع بعملة مختلفة عن عملة الطلبية',
                  style: AppTextStyles.subtitleMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'عملة الطلبية: ${_targetOrder!.currency.nameAr} (المتبقي: ${_targetOrder!.remainingAmount.format()})\n'
            'المبلغ المستلم في الخزنة: ${_amountController.text.isNotEmpty ? _amountController.text : "0"} ${_selectedCurrency.symbolAr}',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppDimensions.space12),
          StoreeTextField(
            label: 'المبلغ المخصوم من حساب الطلبية (${_targetOrder!.currency.symbolAr}) *',
            hint: 'مثال: ${_targetOrder!.remainingAmount.toMajor}',
            controller: _orderDeductionController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              if (_isCrossCurrency && (v == null || v.trim().isEmpty)) {
                return 'يرجى إدخال المبلغ المحسوم من الطلب';
              }
              return null;
            },
            onChanged: (_) => setState(() {}),
          ),
          if (rateHint != null) ...[
            const SizedBox(height: 6),
            Text(
              rateHint,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomerDropdown() {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        if (state is CustomerLoaded) {
          // If no customer selected yet, don't force select first to allow placeholder
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
                  child: DropdownButton<String>(
                    hint: const Text('اختاري العميلة...'),
                    value: _selectedCustomerId,
                    isExpanded: true,
                    items: state.customers.map((c) {
                      return DropdownMenuItem<String>(
                        value: c.id,
                        child: Text('${c.name} (${c.phone})', style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (id) {
                      if (id != null) {
                        setState(() {
                          _selectedCustomerId = id;
                          final customer = state.customers.where((c) => c.id == id).firstOrNull;
                          if (customer != null && widget.preselectedOrder == null) {
                            _selectedCurrency = customer.defaultCurrency;
                            _targetOrder = null;
                            _autoAllocateFifo = true;
                          }
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
            return o.customerId == _selectedCustomerId && !o.remainingAmount.isZero;
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
              Text('تخصيص الدفعة على المستحقات', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),

              // Option 1: Auto-allocate FIFO
              InkWell(
                onTap: () {
                  setState(() {
                    _targetOrder = null;
                    _autoAllocateFifo = true;
                  });
                },
                borderRadius: AppDimensions.roundedMedium,
                child: StoreeCard(
                  backgroundColor: (_targetOrder == null && _autoAllocateFifo)
                      ? AppColors.secondary
                      : AppColors.surface,
                  border: (_targetOrder == null && _autoAllocateFifo)
                      ? Border.all(color: AppColors.primary, width: 1.5)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_mode_rounded,
                              color: (_targetOrder == null && _autoAllocateFifo)
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(width: AppDimensions.space8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'توزيع آلي على الطلبيات (FIFO)',
                                    style: AppTextStyles.subtitleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'يسدد أقدم الطلبيات غير المسددة أولاً',
                                    style: AppTextStyles.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.space8),
                      StoreeBadge(
                        label: (_targetOrder == null && _autoAllocateFifo) ? 'مفعل' : 'اختيار',
                        type: (_targetOrder == null && _autoAllocateFifo)
                            ? BadgeType.primary
                            : BadgeType.info,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.space8),

              // Option 2: Specific order selection
              ...customerUnpaidOrders.map((order) {
                final isSelected = _targetOrder?.id == order.id;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.space8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _targetOrder = null;
                          _autoAllocateFifo = true;
                        } else {
                          _targetOrder = order;
                          _autoAllocateFifo = false;
                          _orderDeductionController.text = order.remainingAmount.toMajor.toString();
                          if (_amountController.text.isEmpty || _amountController.text == '0.0') {
                            _amountController.text = order.remainingAmount.toMajor.toString();
                          }
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'طلبية #${order.orderNumber}',
                                  style: AppTextStyles.subtitleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'المتبقي: ${order.remainingAmount.format()}',
                                  style: AppTextStyles.moneySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppDimensions.space8),
                          StoreeBadge(
                            label: isSelected ? 'طلبية محددة' : 'تخصيص للطلب',
                            type: isSelected ? BadgeType.primary : BadgeType.info,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Option 3: General Credit (No order deduction)
              InkWell(
                onTap: () {
                  setState(() {
                    _targetOrder = null;
                    _autoAllocateFifo = false;
                  });
                },
                borderRadius: AppDimensions.roundedMedium,
                child: StoreeCard(
                  backgroundColor: (_targetOrder == null && !_autoAllocateFifo)
                      ? AppColors.secondary
                      : AppColors.surface,
                  border: (_targetOrder == null && !_autoAllocateFifo)
                      ? Border.all(color: AppColors.primary, width: 1.5)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: (_targetOrder == null && !_autoAllocateFifo)
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              size: 20,
                            ),
                            const SizedBox(width: AppDimensions.space8),
                            Expanded(
                              child: Text(
                                'إيداع كرصيد دائن عام (دون تسديد طلبية)',
                                style: AppTextStyles.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.space8),
                      StoreeBadge(
                        label: (_targetOrder == null && !_autoAllocateFifo) ? 'مفعل' : 'اختيار',
                        type: (_targetOrder == null && !_autoAllocateFifo)
                            ? BadgeType.primary
                            : BadgeType.info,
                      ),
                    ],
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

  Widget _buildWalletDropdown() {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded) {
          if ((_selectedWalletId == null || !state.wallets.any((w) => w.id == _selectedWalletId)) &&
              state.wallets.isNotEmpty) {
            _selectedWalletId = state.wallets.first.id;
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
                  child: DropdownButton<String>(
                    value: _selectedWalletId,
                    isExpanded: true,
                    items: state.wallets.map((w) {
                      return DropdownMenuItem<String>(
                        value: w.id,
                        child: Text('${w.name} (${w.type.labelAr})', style: AppTextStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (id) {
                      if (id != null) setState(() => _selectedWalletId = id);
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
