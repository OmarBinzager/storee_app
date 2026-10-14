import 'dart:io';
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
import '../../../orders/domain/entities/order_item.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
import '../../../wallets/presentation/cubit/wallet_cubit.dart';
import '../../../wallets/presentation/cubit/wallet_state.dart';
import '../../domain/entities/purchase_batch.dart';
import '../../domain/services/batch_cost_allocator.dart';
import '../cubit/purchase_cubit.dart';
import '../cubit/purchase_state.dart';

class CreatePurchaseBatchSheet extends StatefulWidget {
  const CreatePurchaseBatchSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    final purchaseCubit = context.read<PurchaseCubit>();
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
          BlocProvider.value(value: purchaseCubit),
          BlocProvider.value(value: orderBloc),
          BlocProvider.value(value: walletCubit),
        ],
        child: const CreatePurchaseBatchSheet(),
      ),
    );
  }

  @override
  State<CreatePurchaseBatchSheet> createState() => _CreatePurchaseBatchSheetState();
}

class _CreatePurchaseBatchSheetState extends State<CreatePurchaseBatchSheet> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController(text: 'شي إن (SHEIN)');
  final _invoiceRefController = TextEditingController();
  final _shippingController = TextEditingController(text: '0.0');
  final _discountsController = TextEditingController(text: '0.0');

  Currency _selectedCurrency = Currency.sar;
  String? _payingWalletId;
  bool _payFromWallet = true;

  // Track item base cost inputs: Map of orderItemId -> TextEditingController
  final Map<String, TextEditingController> _baseCostControllers = {};
  // Selected order items to include in this batch
  final Set<String> _selectedItemIds = {};

  final _costAllocator = const BatchCostAllocator();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _storeNameController.dispose();
    _invoiceRefController.dispose();
    _shippingController.dispose();
    _discountsController.dispose();
    for (final c in _baseCostControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  List<BatchItemAllocated> _calculateAllocations(List<OrderItem> allUnassigned) {
    // Strictly isolate to items matching the batch's currency
    final selectedItems = allUnassigned
        .where((i) => _selectedItemIds.contains(i.id) && i.saleUnitPrice.currency == _selectedCurrency)
        .toList();
    if (selectedItems.isEmpty) return [];

    final shippingMajor = double.tryParse(_shippingController.text) ?? 0.0;
    final discountMajor = double.tryParse(_discountsController.text) ?? 0.0;

    final shippingMoney = Money.fromMajor(shippingMajor, _selectedCurrency);
    final discountMoney = Money.fromMajor(discountMajor, _selectedCurrency);

    final rawInputs = selectedItems.map((item) {
      final ctrl = _baseCostControllers[item.id];
      final enteredMajor = double.tryParse(ctrl?.text ?? '');
      final baseMajor = enteredMajor ?? (item.saleUnitPrice.currency == _selectedCurrency ? item.saleUnitPrice.toMajor * 0.7 : 0.0);
      final baseMoney = Money.fromMajor(baseMajor, _selectedCurrency);

      return (
        orderItemId: item.id,
        title: item.title,
        quantity: item.quantity,
        baseCost: baseMoney,
      );
    }).toList();

    return _costAllocator.allocate(
      rawItems: rawInputs,
      extraCosts: shippingMoney,
      discounts: discountMoney,
    );
  }

  Future<void> _submit(List<OrderItem> allUnassigned) async {
    if (!_formKey.currentState!.validate()) return;

    final matchingSelected = allUnassigned
        .where((i) => _selectedItemIds.contains(i.id) && i.saleUnitPrice.currency == _selectedCurrency)
        .toList();

    if (matchingSelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء اختيار عنصر واحد على الأقل بعملة ${_selectedCurrency.code} للشراء'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final shippingMajor = double.tryParse(_shippingController.text) ?? 0.0;
    final discountMajor = double.tryParse(_discountsController.text) ?? 0.0;

    final shippingMoney = Money.fromMajor(shippingMajor, _selectedCurrency);
    final discountMoney = Money.fromMajor(discountMajor, _selectedCurrency);

    final allocatedItems = _calculateAllocations(allUnassigned);

    setState(() => _isSubmitting = true);

    final success = await context.read<PurchaseCubit>().createBatch(
          storeName: _storeNameController.text.trim(),
          invoiceReference: _invoiceRefController.text.trim().isNotEmpty ? _invoiceRefController.text.trim() : null,
          currency: _selectedCurrency,
          extraCosts: shippingMoney,
          discounts: discountMoney,
          items: allocatedItems,
          payingWalletId: (_payFromWallet && _payingWalletId != null) ? _payingWalletId : null,
        );

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        // Refresh orders and wallets
        context.read<OrderBloc>().add(const LoadOrdersEvent());
        context.read<WalletCubit>().loadWallets();
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم تسجيل فاتورة الشراء وتوزيع تكاليف الشحن على ${allocatedItems.length} منتجات بنجاح'),
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
      child: BlocBuilder<PurchaseCubit, PurchaseState>(
        builder: (context, state) {
          final unassigned = (state is PurchaseLoaded) ? state.unassignedItems : <OrderItem>[];

          // Initialize controllers for items
          for (final item in unassigned) {
            _baseCostControllers.putIfAbsent(
              item.id,
              () => TextEditingController(text: (item.saleUnitPrice.toMajor * 0.7).toStringAsFixed(1)),
            );
          }

          final allocatedPreview = _calculateAllocations(unassigned);
          var totalBatchCost = Money.zero(_selectedCurrency);
          for (final a in allocatedPreview) {
            totalBatchCost = totalBatchCost + a.totalCost;
          }

          return Form(
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
                      Expanded(
                        child: Text(
                          'فاتورة شراء جماعي جديدة',
                          style: AppTextStyles.headingSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(height: AppDimensions.space24),
                  // Store & Currency
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: StoreeTextField(
                          label: 'اسم المتجر / المورد *',
                          hint: 'شي إن، زارا، أمازون...',
                          controller: _storeNameController,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.space12),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('عملة الفاتورة', style: AppTextStyles.subtitleMedium),
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
                                    return DropdownMenuItem(value: c, child: Text(c.code, style: AppTextStyles.bodyMedium));
                                  }).toList(),
                                  onChanged: (c) {
                                    if (c != null) {
                                      setState(() {
                                        _selectedCurrency = c;
                                        _selectedItemIds.removeWhere((id) {
                                          final item = unassigned.where((i) => i.id == id).firstOrNull;
                                          return item != null && item.saleUnitPrice.currency != c;
                                        });
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
                  const SizedBox(height: AppDimensions.space16),
                  StoreeTextField(
                    label: 'رقم الفاتورة أو المرجع (اختياري)',
                    hint: 'مثال: SHEIN-9087123',
                    controller: _invoiceRefController,
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  // Shipping and Discounts
                  Row(
                    children: [
                      Expanded(
                        child: StoreeTextField(
                          label: 'إجمالي الشحن والجمارك',
                          hint: '0.0',
                          controller: _shippingController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.space12),
                      Expanded(
                        child: StoreeTextField(
                          label: 'خصومات وكوبونات المتجر',
                          hint: '0.0',
                          controller: _discountsController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space20),
                  // Select unassigned items to purchase
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('اختيار المنتجات للشراء الجماعي', style: AppTextStyles.headingSmall),
                      StoreeBadge(
                        label: 'عملة الفاتورة: ${_selectedCurrency.code}',
                        type: BadgeType.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space4),
                  Text(
                    'تظهر فقط منتجات الطلبيات المطابقة لعملة الفاتورة (${_selectedCurrency.code}) لمنع خلط العملات.',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  Builder(
                    builder: (context) {
                      final matchingItems = unassigned
                          .where((item) => item.saleUnitPrice.currency == _selectedCurrency)
                          .toList();
                      final otherItemsCount = unassigned.length - matchingItems.length;

                      if (matchingItems.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(AppDimensions.space16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: AppDimensions.roundedMedium,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'لا توجد منتجات بانتظار الشراء بعملة ${_selectedCurrency.code} حالياً.',
                                style: AppTextStyles.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                              if (otherItemsCount > 0) ...[
                                const SizedBox(height: 8),
                                Text(
                                  '💡 يوجد $otherItemsCount منتجات بانتظار الشراء بعملات أخرى. يمكنك تغيير عملة الفاتورة من القائمة بالأعلى.',
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          if (otherItemsCount > 0)
                            Padding(
                              padding: const EdgeInsets.only(bottom: AppDimensions.space8),
                              child: Text(
                                '💡 يوجد $otherItemsCount منتجات أخرى بعملات مختلفة مستبعدة تلقائياً لتفادي خلط العملات.',
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 11),
                              ),
                            ),
                          ...matchingItems.map((item) => _buildItemSelectionCard(item)),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  // Allocated preview banner
                  if (_selectedItemIds.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.space16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: AppDimensions.roundedMedium,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'إجمالي الفاتورة المطلوب دفعها:',
                                  style: AppTextStyles.subtitleLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: AppDimensions.space8),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(totalBatchCost.format(), style: AppTextStyles.moneyLarge),
                              ),
                            ],
                          ),
                          const Divider(height: AppDimensions.space16),
                          Text(
                            'توزيع تكلفة الشحن على المنتجات المحددة:',
                            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          ...allocatedPreview.map((a) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '• ${a.title}',
                                            style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: AppDimensions.space8),
                                        Text(
                                          'الإجمالي: ${a.totalCost.format()}',
                                          style: AppTextStyles.bodySmall.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'حصة الشحن والرسوم: ${a.allocatedExtraCost.format()}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space16),
                  ],
                  // Payment from wallet option
                  _buildPaymentWalletSection(),
                  const SizedBox(height: AppDimensions.space24),
                  StoreeButton(
                    label: 'اعتماد الشراء وتوزيع التكاليف',
                    icon: Icons.check_circle_outline,
                    isLoading: _isSubmitting,
                    onPressed: () => _submit(unassigned),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemSelectionCard(OrderItem item) {
    final isSelected = _selectedItemIds.contains(item.id);
    final ctrl = _baseCostControllers[item.id]!;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space8),
      child: StoreeCard(
        backgroundColor: isSelected ? AppColors.secondaryLight : AppColors.surface,
        border: isSelected ? Border.all(color: AppColors.primary, width: 1.5) : null,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isSelected,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _selectedItemIds.add(item.id);
                      } else {
                        _selectedItemIds.remove(item.id);
                      }
                    });
                  },
                ),
                if (item.imagePath != null && File(item.imagePath!).existsSync()) ...[
                  ClipRRect(
                    borderRadius: AppDimensions.roundedSmall,
                    child: Image.file(
                      File(item.imagePath!),
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 44,
                        height: 44,
                        color: AppColors.background,
                        child: const Icon(Icons.broken_image_outlined, size: 20, color: AppColors.textTertiary),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTextStyles.subtitleMedium),
                      if (item.hasOptionalDetails) ...[
                        Text(
                          item.specsDescription,
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 11),
                        ),
                      ],
                      Text(
                        'سعر البيع للعميلة: ${item.saleUnitPrice.format()} × ${item.quantity}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                StoreeBadge(
                  label: '${item.quantity} قطع',
                  type: BadgeType.primary,
                ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: AppDimensions.space8),
              Row(
                children: [
                  Expanded(
                    child: StoreeTextField(
                      label: 'سعر الشراء الفعلي من الموقع للقطعة *',
                      hint: '0.0',
                      controller: ctrl,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentWalletSection() {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoaded && state.wallets.isNotEmpty) {
          if (_payingWalletId == null || !state.wallets.any((w) => w.id == _payingWalletId)) {
            _payingWalletId = state.wallets.first.id;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('سداد قيمة الفاتورة فورياً من خزينة', style: AppTextStyles.subtitleMedium),
                value: _payFromWallet,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => _payFromWallet = val ?? false),
              ),
              if (_payFromWallet) ...[
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
                      value: _payingWalletId,
                      isExpanded: true,
                      items: state.wallets.map((w) {
                        final balance = w.getBalanceFor(_selectedCurrency);
                        return DropdownMenuItem<String>(
                          value: w.id,
                          child: Text('${w.name} (${w.type.labelAr}) - الرصيد: ${balance.format()}', style: AppTextStyles.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (walletId) {
                        if (walletId != null) setState(() => _payingWalletId = walletId);
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
