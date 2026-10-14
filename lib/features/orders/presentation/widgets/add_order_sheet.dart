import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/cubit/customer_cubit.dart';
import '../../../customers/presentation/cubit/customer_state.dart';
import '../../../customers/presentation/widgets/add_customer_dialog.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/entities/order_item.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';

class AddOrderSheet extends StatefulWidget {
  const AddOrderSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    final customerCubit = context.read<CustomerCubit>();
    final orderBloc = context.read<OrderBloc>();
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
        ],
        child: const AddOrderSheet(),
      ),
    );
  }

  @override
  State<AddOrderSheet> createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  final _formKey = GlobalKey<FormState>();
  final _orderNumberController = TextEditingController();
  final _notesController = TextEditingController();

  Customer? _selectedCustomer;
  Currency _selectedCurrency = Currency.sar;

  // Items in this order
  final List<_NewItemRow> _itemRows = [];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Default order number
    final randomDigits = (1000 + DateTime.now().millisecond).toString();
    _orderNumberController.text = '#$randomDigits';

    // Start with 1 default empty item row
    _addItemRow();
  }

  void _addItemRow() {
    setState(() {
      _itemRows.add(_NewItemRow());
    });
  }

  void _removeItemRow(int index) {
    if (_itemRows.length <= 1) return;
    setState(() {
      _itemRows.removeAt(index);
    });
  }

  @override
  void dispose() {
    _orderNumberController.dispose();
    _notesController.dispose();
    for (final row in _itemRows) {
      row.dispose();
    }
    super.dispose();
  }

  Money _calculateTotal() {
    var total = Money.zero(_selectedCurrency);
    for (final row in _itemRows) {
      final priceMajor = double.tryParse(row.priceController.text) ?? 0.0;
      final qty = int.tryParse(row.qtyController.text) ?? 1;
      final itemPrice = Money.fromMajor(priceMajor, _selectedCurrency) * qty;
      total = total + itemPrice;
    }
    return total;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار العميلة صاحبة الطلب أولاً'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final orderId = const Uuid().v4();
    final items = _itemRows.map((row) {
      final priceMajor = double.tryParse(row.priceController.text) ?? 0.0;
      final qty = int.tryParse(row.qtyController.text) ?? 1;

      return OrderItem(
        id: const Uuid().v4(),
        orderId: orderId,
        title: row.titleController.text.trim(),
        imagePath: row.imagePath,
        color: row.colorController.text.trim().isNotEmpty ? row.colorController.text.trim() : null,
        size: row.sizeController.text.trim().isNotEmpty ? row.sizeController.text.trim() : null,
        notes: row.notesController.text.trim().isNotEmpty ? row.notesController.text.trim() : null,
        quantity: qty,
        saleUnitPrice: Money.fromMajor(priceMajor, _selectedCurrency),
      );
    }).toList();

    final order = CustomerOrder(
      id: orderId,
      customerId: _selectedCustomer!.id,
      customerName: _selectedCustomer!.name,
      orderNumber: _orderNumberController.text.trim(),
      executionStatus: OrderExecutionStatus.newOrder,
      paymentStatus: OrderPaymentStatus.unpaid,
      currency: _selectedCurrency,
      items: items,
      paidAmount: Money.zero(_selectedCurrency),
      discountAmount: Money.zero(_selectedCurrency),
      notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    context.read<OrderBloc>().add(AddOrderEvent(order));

    if (mounted) {
      setState(() => _isSubmitting = false);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إنشاء الطلب ${order.orderNumber} للعميلة ${order.customerName} بنجاح'),
          backgroundColor: AppColors.primary,
        ),
      );
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
                  Text('إنشاء طلبية جديدة', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: AppDimensions.space24),
              // Customer Selection
              _buildCustomerSelector(context),
              const SizedBox(height: AppDimensions.space16),
              // Order Number and Currency
              Row(
                children: [
                  Expanded(
                    child: StoreeTextField(
                      label: 'رقم الطلب *',
                      controller: _orderNumberController,
                      validator: (val) => (val == null || val.trim().isEmpty) ? 'مطلوب' : null,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('عملة البيع', style: AppTextStyles.subtitleMedium),
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
                                  child: Text('${c.nameAr} (${c.code})', style: AppTextStyles.bodyMedium),
                                );
                              }).toList(),
                              onChanged: (c) {
                                if (c != null) {
                                  setState(() => _selectedCurrency = c);
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
              const SizedBox(height: AppDimensions.space24),
              // Items section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('عناصر ومنتجات الطلب', style: AppTextStyles.headingSmall),
                  TextButton.icon(
                    onPressed: _addItemRow,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('إضافة منتج'),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space8),
              ..._itemRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return _buildItemRowCard(idx, row);
              }),
              const SizedBox(height: AppDimensions.space16),
              // Total calculation banner
              Container(
                padding: const EdgeInsets.all(AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppDimensions.roundedMedium,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'إجمالي الطلبية المتوقع:',
                        style: AppTextStyles.subtitleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _calculateTotal().format(),
                        style: AppTextStyles.moneyLarge.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
              StoreeTextField(
                label: 'ملاحظات الطلب',
                hint: 'تفاصيل شحن خاصة أو رابط متجر...',
                controller: _notesController,
                maxLines: 2,
              ),
              const SizedBox(height: AppDimensions.space24),
              StoreeButton(
                label: 'حفظ الطلبية',
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

  Widget _buildCustomerSelector(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        if (state is CustomerLoaded) {
          final customers = state.customers;

          if (customers.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(AppDimensions.space12),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: AppDimensions.roundedMedium,
                border: Border.all(color: AppColors.warning),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
                  const SizedBox(width: AppDimensions.space8),
                  Expanded(
                    child: Text('لا توجد عميلات مسجلات حتى الآن.', style: AppTextStyles.bodySmall),
                  ),
                  TextButton(
                    onPressed: () => AddCustomerDialog.show(context),
                    child: const Text('إضافة عميلة الآن'),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('اختيار العميلة *', style: AppTextStyles.subtitleMedium),
                  InkWell(
                    onTap: () => AddCustomerDialog.show(context),
                    child: Text(
                      '+ عميلة جديدة',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
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
                    items: customers.map((c) {
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
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _pickImageForItem(_NewItemRow row) async {
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource?>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusMedium)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.space12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('صورة المنتج', style: AppTextStyles.subtitleMedium),
              const SizedBox(height: AppDimensions.space8),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: AppColors.primary),
                title: const Text('اختيار من المعرض (Gallery)'),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: AppColors.primary),
                title: const Text('التقاط صورة بالكاميرا (Camera)'),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              if (row.imagePath != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                  title: const Text('إزالة الصورة الحالية', style: TextStyle(color: AppColors.error)),
                  onTap: () {
                    setState(() {
                      row.imagePath = null;
                    });
                    Navigator.pop(ctx, null);
                  },
                ),
            ],
          ),
        ),
      ),
    );

    if (source != null) {
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          row.imagePath = picked.path;
        });
      }
    }
  }

  Widget _buildItemRowCard(int index, _NewItemRow row) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.space12),
      padding: const EdgeInsets.all(AppDimensions.space12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Image Picker Box + Product Title + Delete
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _pickImageForItem(row),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.35),
                    borderRadius: AppDimensions.roundedSmall,
                    border: Border.all(
                      color: row.imagePath != null ? AppColors.primary : AppColors.border,
                      width: row.imagePath != null ? 1.5 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: row.imagePath != null && File(row.imagePath!).existsSync()
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(row.imagePath!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.broken_image_outlined,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black45,
                                padding: const EdgeInsets.symmetric(vertical: 1),
                                child: const Icon(Icons.edit, size: 12, color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_a_photo_outlined, size: 20, color: AppColors.primary),
                            const SizedBox(height: 2),
                            Text(
                              'صورة',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 10,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(width: AppDimensions.space12),
              Expanded(
                child: StoreeTextField(
                  label: 'اسم المنتج *',
                  hint: 'مثال: فستان سهرة مخمل',
                  controller: row.titleController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                ),
              ),
              if (_itemRows.length > 1)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () => _removeItemRow(index),
                  tooltip: 'حذف المنتج',
                ),
            ],
          ),
          const SizedBox(height: AppDimensions.space12),
          // Row 2: Price & Quantity
          Row(
            children: [
              Expanded(
                flex: 2,
                child: StoreeTextField(
                  label: 'سعر البيع للوحدة *',
                  hint: '0.0',
                  controller: row.priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: AppDimensions.space8),
              Expanded(
                flex: 1,
                child: StoreeTextField(
                  label: 'الكمية *',
                  controller: row.qtyController,
                  keyboardType: TextInputType.number,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          // Expandable Optional Specifications
          InkWell(
            onTap: () {
              setState(() {
                row.isExpanded = !row.isExpanded;
              });
            },
            borderRadius: AppDimensions.roundedSmall,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    row.isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    row.isExpanded
                        ? 'إخفاء المواصفات'
                        : '+ مواصفات اختيارية (المقاس، اللون، الخامة...)',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (!row.isExpanded &&
                      (row.sizeController.text.isNotEmpty ||
                          row.colorController.text.isNotEmpty ||
                          row.notesController.text.isNotEmpty)) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (row.isExpanded) ...[
            const SizedBox(height: AppDimensions.space8),
            Row(
              children: [
                Expanded(
                  child: StoreeTextField(
                    label: 'المقاس (اختياري)',
                    hint: 'M, L, 38...',
                    controller: row.sizeController,
                  ),
                ),
                const SizedBox(width: AppDimensions.space8),
                Expanded(
                  child: StoreeTextField(
                    label: 'اللون (اختياري)',
                    hint: 'كحلي، وردي...',
                    controller: row.colorController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space8),
            StoreeTextField(
              label: 'ملاحظات / خامة المنتج (اختياري)',
              hint: 'خامة كريب ملكي، تطريز يدوي، طول 56...',
              controller: row.notesController,
            ),
          ],
        ],
      ),
    );
  }
}

class _NewItemRow {
  String? imagePath;
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController(text: '1');
  final sizeController = TextEditingController();
  final colorController = TextEditingController();
  final notesController = TextEditingController();
  bool isExpanded = false;

  void dispose() {
    titleController.dispose();
    priceController.dispose();
    qtyController.dispose();
    sizeController.dispose();
    colorController.dispose();
    notesController.dispose();
  }
}
