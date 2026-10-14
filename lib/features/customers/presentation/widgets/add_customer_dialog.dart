import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
    final customerCubit = context.read<CustomerCubit>();
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusLarge)),
      ),
      builder: (_) => BlocProvider.value(
        value: customerCubit,
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
  bool _isImportingContact = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _importFromPhoneBook() async {
    setState(() => _isImportingContact = true);
    try {
      final status = await FlutterContacts.permissions.request(PermissionType.read);
      if (status != PermissionStatus.granted && status != PermissionStatus.limited) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('الرجاء منح إذن الوصول إلى جهات الاتصال لاستيراد بيانات العميلة'),
              backgroundColor: AppColors.warning,
            ),
          );
        }
        return;
      }

      final contact = await FlutterContacts.native.showPicker();
      if (contact == null) return;

      // Fetch full contact to ensure phones list is loaded
      final fullContact = (contact.id != null)
          ? (await FlutterContacts.get(contact.id!) ?? contact)
          : contact;

      String name = (fullContact.displayName ?? '').trim();
      if (name.isEmpty && fullContact.name != null) {
        final first = (fullContact.name?.first ?? '').trim();
        final last = (fullContact.name?.last ?? '').trim();
        name = '$first $last'.trim();
      }

      String phone = '';
      if (fullContact.phones.isNotEmpty) {
        if (fullContact.phones.length == 1) {
          phone = fullContact.phones.first.number;
        } else {
          if (mounted) {
            final chosen = await showModalBottomSheet<String>(
              context: context,
              backgroundColor: AppColors.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusMedium)),
              ),
              builder: (ctx) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppDimensions.space16),
                      child: Text(
                        'اختاري رقم الهاتف للعميلة: $name',
                        style: AppTextStyles.subtitleMedium,
                      ),
                    ),
                    const Divider(height: 1),
                    ...fullContact.phones.map(
                      (p) => ListTile(
                        leading: const Icon(Icons.phone_rounded, color: AppColors.primary),
                        title: Text(p.number, textDirection: TextDirection.ltr),
                        subtitle: Text(p.label.toString()),
                        onTap: () => Navigator.pop(ctx, p.number),
                      ),
                    ),
                  ],
                ),
              ),
            );
            phone = chosen ?? fullContact.phones.first.number;
          }
        }
      }

      // Clean phone number: remove non-digit characters except leading +
      var cleanPhone = phone.trim();
      if (cleanPhone.startsWith('+')) {
        cleanPhone = '+${cleanPhone.substring(1).replaceAll(RegExp(r'\D'), '')}';
      } else {
        cleanPhone = cleanPhone.replaceAll(RegExp(r'\D'), '');
      }

      setState(() {
        if (name.isNotEmpty) {
          _nameController.text = name;
        }
        if (cleanPhone.isNotEmpty) {
          _phoneController.text = cleanPhone;
        }
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم استيراد بيانات العميلة "$name" بنجاح'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تعذر استيراد جهة الاتصال: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isImportingContact = false);
      }
    }
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
              // Quick import from phone book
              InkWell(
                onTap: _isImportingContact ? null : _importFromPhoneBook,
                borderRadius: AppDimensions.roundedMedium,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.space16,
                    vertical: AppDimensions.space12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    borderRadius: AppDimensions.roundedMedium,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.space8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: _isImportingContact
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                              )
                            : const Icon(Icons.contacts_rounded, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: AppDimensions.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'استيراد من جهات الاتصال',
                              style: AppTextStyles.subtitleMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'اختاري عميلة من سجل الهاتف لتعبئة الاسم والرقم تلقائياً',
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
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
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contact_phone_outlined, color: AppColors.primary),
                  tooltip: 'استيراد من جهات الاتصال',
                  onPressed: _isImportingContact ? null : _importFromPhoneBook,
                ),
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
