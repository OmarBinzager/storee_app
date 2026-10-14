import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/storee_badge.dart';
import '../../../../core/widgets/storee_button.dart';
import '../../../../core/widgets/storee_card.dart';
import '../../../../core/widgets/storee_text_field.dart';
import '../../domain/entities/app_license.dart';
import '../cubit/license_cubit.dart';
import '../cubit/license_state.dart';

class StoreeLicensePage extends StatefulWidget {
  const StoreeLicensePage({super.key});

  @override
  State<StoreeLicensePage> createState() => _StoreeLicensePageState();
}

class _StoreeLicensePageState extends State<StoreeLicensePage> {
  final _keyController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _keyController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الترخيص والاشتراك'),
      ),
      body: BlocConsumer<LicenseCubit, LicenseState>(
        listener: (context, state) {
          if (state is LicenseActivationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
            );
            _keyController.clear();
          } else if (state is LicenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LicenseLoading;
          AppLicense? license;

          if (state is LicenseLoaded) {
            license = state.license;
          } else if (state is LicenseActivationSuccess) {
            license = state.license;
          }

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.space16),
            children: [
              if (license != null) _buildLicenseStatusCard(license),
              const SizedBox(height: AppDimensions.space20),
              _buildActivationSection(context, isLoading),
              const SizedBox(height: AppDimensions.space24),
              _buildSupportCard(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLicenseStatusCard(AppLicense license) {
    String statusTitle;
    BadgeType badgeType;
    Color statusColor;

    if (!license.isExpired) {
      statusTitle = license.isTrial ? 'نسخة تجريبية نشطة' : 'الترخيص نشط ومعتمد';
      badgeType = BadgeType.success;
      statusColor = AppColors.success;
    } else if (license.isInGracePeriod) {
      statusTitle = 'فترة سماح نشطة (${license.remainingGraceDays} أيام متبقية)';
      badgeType = BadgeType.warning;
      statusColor = AppColors.warning;
    } else {
      statusTitle = 'الترخيص منتهي';
      badgeType = BadgeType.error;
      statusColor = AppColors.error;
    }

    return StoreeCard(
      backgroundColor: AppColors.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.workspace_premium_rounded, color: statusColor, size: 28),
                  const SizedBox(width: AppDimensions.space8),
                  Text('حالة الاشتراك', style: AppTextStyles.headingSmall),
                ],
              ),
              StoreeBadge(label: statusTitle, type: badgeType),
            ],
          ),
          const Divider(height: AppDimensions.space20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('اسم المتجر / المشتركة:', style: AppTextStyles.bodySmall),
              Text(license.clientName, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المتبقي على انتهاء الصلاحية:', style: AppTextStyles.bodySmall),
              Text(
                '${license.remainingDays} يوماً',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تاريخ الانتهاء:', style: AppTextStyles.bodySmall),
              Text(_formatDate(license.expiresAt), style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('رقم الترخيص الحالي:', style: AppTextStyles.bodySmall),
              Text(license.licenseKey, style: AppTextStyles.bodySmall.copyWith(fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivationSection(BuildContext context, bool isLoading) {
    return StoreeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تفعيل ترخيص جديد أو تمديد الاشتراك', style: AppTextStyles.headingSmall),
          const SizedBox(height: AppDimensions.space4),
          Text(
            'أدخلي مفتاح الترخيص المستلم من خدمة عملاء ستوري للتفعيل الفوري بدون إنترنت.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppDimensions.space16),
          StoreeTextField(
            label: 'اسم التاجرة / المتجر (اختياري)',
            hint: 'مثال: بوتيك الأناقة',
            controller: _nameController,
          ),
          const SizedBox(height: AppDimensions.space12),
          StoreeTextField(
            label: 'مفتاح الترخيص *',
            hint: 'STOREE-PRO-202712-XXXX',
            controller: _keyController,
          ),
          const SizedBox(height: AppDimensions.space16),
          StoreeButton(
            label: 'تفعيل الترخيص الآن',
            icon: Icons.check_circle_outline,
            isLoading: isLoading,
            onPressed: () {
              final key = _keyController.text.trim();
              if (key.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('الرجاء إدخال مفتاح الترخيص'), backgroundColor: AppColors.error),
                );
                return;
              }
              final name = _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null;
              context.read<LicenseCubit>().activateKey(key, clientName: name);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.support_agent_rounded, color: AppColors.info, size: 28),
          const SizedBox(width: AppDimensions.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الدعم الفني وتجديد الاشتراك', style: AppTextStyles.subtitleMedium),
                const SizedBox(height: 4),
                Text(
                  'للحصول على مفتاح التفعيل الرسمي أو تجديد اشتراكك السنوي، تواصل مع فريق ستوري عبر واتساب مباشرة.',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
