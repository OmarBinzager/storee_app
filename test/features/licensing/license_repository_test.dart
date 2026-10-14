import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storee/features/licensing/data/datasources/license_local_datasource.dart';
import 'package:storee/features/licensing/data/repositories/license_repository_impl.dart';

void main() {
  late SharedPreferences prefs;
  late LicenseLocalDataSource localDataSource;
  late LicenseRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    localDataSource = LicenseLocalDataSourceImpl(prefs);
    repository = LicenseRepositoryImpl(localDataSource);
  });

  group('LicenseRepository Offline Licensing & Grace Period Tests', () {
    test('initializes 14-day trial on first launch', () async {
      final result = await repository.getActiveLicense();
      expect(result.isRight(), true);

      final license = result.getOrElse(() => throw Exception());
      expect(license.isTrial, true);
      expect(license.isValid, true);
      expect(license.isExpired, false);
      expect(license.remainingDays >= 13, true);
    });

    test('activates offline license with valid cryptographic signature', () async {
      // Generate signature for STOREE-PRO-202812
      const base = 'STOREE-PRO-202812';
      final sig = LicenseLocalDataSourceImpl.generateSignature(base);
      final validKey = '$base-$sig';

      final result = await repository.activateLicense(validKey, clientName: 'بوتيك ياسمين الشام');
      expect(result.isRight(), true);

      final license = result.getOrElse(() => throw Exception());
      expect(license.isTrial, false);
      expect(license.clientName, 'بوتيك ياسمين الشام');
      expect(license.licenseKey, validKey);
      expect(license.isValid, true);
      expect(license.expiresAt.year, 2028);
      expect(license.expiresAt.month, 12);
    });

    test('rejects tampered or forged license key with Failure', () async {
      const forgedKey = 'STOREE-PRO-202812-DEAD';
      final result = await repository.activateLicense(forgedKey);
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message.contains('غير صالح'), true),
        (_) => fail('Expected failure for forged signature'),
      );
    });
  });
}
