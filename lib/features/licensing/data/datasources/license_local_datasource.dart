import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/app_license.dart';

abstract class LicenseLocalDataSource {
  Future<AppLicense> getActiveLicense();
  Future<AppLicense> activateLicense(String licenseKey, {String? clientName});
  Future<AppLicense> startTrial({String? clientName});
}

class LicenseLocalDataSourceImpl implements LicenseLocalDataSource {
  final SharedPreferences preferences;
  static const String _licensePrefKey = 'storee_active_license_v1';
  static const String _salt = 'STOREE_OFFLINE_SECRET_SALT_2026';

  LicenseLocalDataSourceImpl(this.preferences);

  static String generateSignature(String base) {
    final bytes = utf8.encode('$base:$_salt');
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 4).toUpperCase();
  }

  @override
  Future<AppLicense> getActiveLicense() async {
    final raw = preferences.getString(_licensePrefKey);
    if (raw == null) {
      // First launch: initialize default 14-day free trial
      return startTrial();
    }

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return AppLicense.fromJson(json);
    } catch (e) {
      throw DatabaseException('فشل في قراءة بيانات الترخيص المحلي: $e');
    }
  }

  @override
  Future<AppLicense> activateLicense(String rawKey, {String? clientName}) async {
    final key = rawKey.trim().toUpperCase();
    final parts = key.split('-');

    // Format: STOREE-<TYPE>-<YYYYMM>-<SIG>
    // e.g. STOREE-PRO-202712-XXXX
    if (parts.length != 4 || parts[0] != 'STOREE') {
      throw const DatabaseException('صيغة مفتاح الترخيص غير صحيحة. يجب أن تبدأ بـ STOREE-');
    }

    final type = parts[1];
    final yyyymm = parts[2];
    final sig = parts[3];

    final expectedSig = generateSignature('STOREE-$type-$yyyymm');
    if (sig != expectedSig) {
      throw const DatabaseException('مفتاح الترخيص غير صالح أو لم يتم التحقق من توقيعه');
    }

    if (yyyymm.length != 6) {
      throw const DatabaseException('تاريخ انتهاء الترخيص في المفتاح غير صالح');
    }

    final year = int.tryParse(yyyymm.substring(0, 4));
    final month = int.tryParse(yyyymm.substring(4, 6));

    if (year == null || month == null || month < 1 || month > 12) {
      throw const DatabaseException('تاريخ انتهاء الترخيص غير صحيح');
    }

    // Set expiry to last day of that month
    final lastDay = DateTime(year, month + 1, 0, 23, 59, 59);

    final license = AppLicense(
      licenseKey: key,
      clientName: clientName ?? 'تاجر ستوري المعتمد',
      issuedAt: DateTime.now(),
      expiresAt: lastDay,
      gracePeriodDays: 14,
      isTrial: false,
    );

    await preferences.setString(_licensePrefKey, jsonEncode(license.toJson()));
    return license;
  }

  @override
  Future<AppLicense> startTrial({String? clientName}) async {
    final now = DateTime.now();
    final trialLicense = AppLicense(
      licenseKey: 'STOREE-TRIAL-14DAYS',
      clientName: clientName ?? 'نسخة تجريبية مجانية',
      issuedAt: now,
      expiresAt: now.add(const Duration(days: 14)),
      gracePeriodDays: 7,
      isTrial: true,
    );

    await preferences.setString(_licensePrefKey, jsonEncode(trialLicense.toJson()));
    return trialLicense;
  }
}
