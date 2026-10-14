import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/store_profile.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences preferences;

  static const _keyStoreName = 'storee_store_name';
  static const _keyOwnerPhone = 'storee_owner_phone';
  static const _keyThankYou = 'storee_thank_you_msg';
  static const _keyDefaultCurrency = 'storee_default_currency';

  const SettingsRepositoryImpl(this.preferences);

  @override
  Future<Either<Failure, StoreProfile>> getStoreProfile() async {
    try {
      final storeName = preferences.getString(_keyStoreName) ?? 'ستوري بوتيك';
      final ownerPhone = preferences.getString(_keyOwnerPhone) ?? '';
      final thankYou = preferences.getString(_keyThankYou) ?? 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨';
      final defaultCurrency = preferences.getString(_keyDefaultCurrency) ?? 'SAR';

      return Right(
        StoreProfile(
          storeName: storeName,
          ownerPhone: ownerPhone,
          customThankYou: thankYou,
          defaultCurrencyCode: defaultCurrency,
        ),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveStoreProfile(StoreProfile profile) async {
    try {
      await preferences.setString(_keyStoreName, profile.storeName);
      await preferences.setString(_keyOwnerPhone, profile.ownerPhone);
      await preferences.setString(_keyThankYou, profile.customThankYou);
      await preferences.setString(_keyDefaultCurrency, profile.defaultCurrencyCode);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
