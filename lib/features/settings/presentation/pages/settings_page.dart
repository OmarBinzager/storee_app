import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../domain/entities/store_profile.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../../../security/presentation/cubit/security_cubit.dart';
import '../../../security/presentation/cubit/security_state.dart';
import '../../../security/presentation/widgets/set_pin_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _storeNameController;
  late TextEditingController _phoneController;
  late TextEditingController _thankYouController;
  String _selectedCurrency = 'SAR';

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _storeNameController = TextEditingController();
    _phoneController = TextEditingController();
    _thankYouController = TextEditingController();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _phoneController.dispose();
    _thankYouController.dispose();
    super.dispose();
  }

  void _initFields(StoreProfile profile) {
    if (!_isInitialized) {
      _storeNameController.text = profile.storeName;
      _phoneController.text = profile.ownerPhone;
      _thankYouController.text = profile.customThankYou;
      _selectedCurrency = profile.defaultCurrencyCode;
      _isInitialized = true;
    }
  }

  void _save(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final updatedProfile = StoreProfile(
      storeName: _storeNameController.text.trim(),
      ownerPhone: _phoneController.text.trim(),
      customThankYou: _thankYouController.text.trim(),
      defaultCurrencyCode: _selectedCurrency,
    );

    context.read<SettingsCubit>().updateSettings(updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات المتجر والهوية'),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          } else if (state is SettingsLoaded && state.isSavedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم حفظ إعدادات وهوية البوتيك بنجاح 🌸'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsLoaded) {
            _initFields(state.profile);

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.space16),
                children: [
                  Text('هوية البوتيك ومعلومات التواصل', style: AppTextStyles.headingSmall),
                  const SizedBox(height: 4),
                  Text(
                    'تظهر هذه البيانات تلقائياً في ترويسة وإيصالات واتساب المرسلة للعميلات.',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppDimensions.space16),

                  StoreeTextField(
                    label: 'اسم البوتيك / المتجر',
                    controller: _storeNameController,
                    hint: 'مثال: بوتيك الأناقة',
                    validator: (v) => v == null || v.trim().isEmpty ? 'الرجاء إدخال اسم المتجر' : null,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppDimensions.space12),

                  StoreeTextField(
                    label: 'رقم هاتف البوتيك (اختياري)',
                    controller: _phoneController,
                    hint: '777123456',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: AppDimensions.space12),

                  StoreeTextField(
                    label: 'رسالة الشكر والتذييل في الفواتير',
                    controller: _thankYouController,
                    hint: 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨',
                    maxLines: 2,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppDimensions.space16),

                  Text('العملة الافتراضية المفضلة', style: AppTextStyles.subtitleMedium),
                  const SizedBox(height: AppDimensions.space8),
                  Wrap(
                    spacing: AppDimensions.space8,
                    children: [
                      ChoiceChip(
                        label: const Text('ريال سعودي (SAR)'),
                        selected: _selectedCurrency == 'SAR',
                        onSelected: (val) {
                          if (val) setState(() => _selectedCurrency = 'SAR');
                        },
                      ),
                      ChoiceChip(
                        label: const Text('ريال يمني (YER)'),
                        selected: _selectedCurrency == 'YER',
                        onSelected: (val) {
                          if (val) setState(() => _selectedCurrency = 'YER');
                        },
                      ),
                      ChoiceChip(
                        label: const Text('دولار أمريكي (USD)'),
                        selected: _selectedCurrency == 'USD',
                        onSelected: (val) {
                          if (val) setState(() => _selectedCurrency = 'USD');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space24),

                  // Receipt Live Preview
                  Text('معاينة حية لترويسة وتذييل الفاتورة:', style: AppTextStyles.subtitleMedium),
                  const SizedBox(height: AppDimensions.space8),
                  StoreeCard(
                    backgroundColor: AppColors.secondary.withValues(alpha: 0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '🌸 *${_storeNameController.text.isNotEmpty ? _storeNameController.text : "ستوري بوتيك"}* 🌸',
                          style: AppTextStyles.subtitleLarge.copyWith(color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(color: AppColors.border),
                        Text(
                          '📋 فاتورة طلبية: #1001\n👤 العميلة العزيزة: هند العولقي\n💰 الإجمالي: 150 ر.س',
                          style: AppTextStyles.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const Divider(color: AppColors.border),
                        Text(
                          _thankYouController.text.isNotEmpty
                              ? _thankYouController.text
                              : 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontStyle: FontStyle.italic,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space24),

                  // Security & App Lock
                  Text('الأمان وقفل التطبيق', style: AppTextStyles.subtitleMedium),
                  const SizedBox(height: AppDimensions.space8),
                  BlocBuilder<SecurityCubit, SecurityState>(
                    builder: (context, securityState) {
                      final isPinEnabled = securityState is SecurityUnlocked && securityState.isPinEnabled;

                      return StoreeCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppDimensions.space8),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: AppDimensions.roundedSmall,
                                  ),
                                  child: const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 22),
                                ),
                                const SizedBox(width: AppDimensions.space12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('قفل التطبيق برمز مرور (PIN)', style: AppTextStyles.subtitleMedium),
                                    const SizedBox(height: 2),
                                    Text(
                                      isPinEnabled ? 'مفعّل (رمز مكون من 4 أرقام)' : 'غير مفعّل',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: isPinEnabled ? AppColors.success : AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Switch.adaptive(
                              value: isPinEnabled,
                              activeTrackColor: AppColors.primary,
                              onChanged: (enabled) {
                                if (enabled) {
                                  SetPinDialog.show(context);
                                } else {
                                  context.read<SecurityCubit>().disablePin();
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.space24),

                  StoreeButton(
                    label: 'حفظ الإعدادات',
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: () => _save(context),
                  ),
                  const SizedBox(height: AppDimensions.space24),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
