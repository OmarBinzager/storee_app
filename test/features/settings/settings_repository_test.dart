import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storee/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:storee/features/settings/domain/entities/store_profile.dart';
import 'package:storee/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:storee/features/settings/presentation/cubit/settings_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences prefs;
  late SettingsRepositoryImpl repository;
  late SettingsCubit cubit;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = SettingsRepositoryImpl(prefs);
    cubit = SettingsCubit(repository);
  });

  tearDown(() {
    cubit.close();
  });

  group('SettingsRepository & SettingsCubit Tests', () {
    test('returns default StoreProfile when no preferences exist', () async {
      final result = await repository.getStoreProfile();
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected right'),
        (profile) {
          expect(profile.storeName, 'ستوري بوتيك');
          expect(profile.defaultCurrencyCode, 'SAR');
          expect(profile.customThankYou, contains('شكراً لثقتكِ'));
        },
      );
    });

    test('saves and retrieves updated StoreProfile accurately', () async {
      const updated = StoreProfile(
        storeName: 'فاشن روز بوتيك',
        ownerPhone: '967777123456',
        customThankYou: 'نسعد دائماً بخدمتكِ 🌹',
        defaultCurrencyCode: 'YER',
      );

      final saveResult = await repository.saveStoreProfile(updated);
      expect(saveResult.isRight(), true);

      final getResult = await repository.getStoreProfile();
      getResult.fold(
        (_) => fail('Expected right'),
        (profile) {
          expect(profile.storeName, 'فاشن روز بوتيك');
          expect(profile.ownerPhone, '967777123456');
          expect(profile.customThankYou, 'نسعد دائماً بخدمتكِ 🌹');
          expect(profile.defaultCurrencyCode, 'YER');
        },
      );
    });

    test('SettingsCubit loads and emits SettingsLoaded with store profile', () async {
      await cubit.loadSettings();
      expect(cubit.state, isA<SettingsLoaded>());
      final loaded = cubit.state as SettingsLoaded;
      expect(loaded.profile.storeName, 'ستوري بوتيك');
    });

    test('SettingsCubit updates settings successfully and emits new state', () async {
      const newProfile = StoreProfile(
        storeName: 'ملكة الأناقة',
        ownerPhone: '966500123456',
        customThankYou: 'دمتِ بأناقة ✨',
        defaultCurrencyCode: 'SAR',
      );

      final success = await cubit.updateSettings(newProfile);
      expect(success, true);
      expect(cubit.state, isA<SettingsLoaded>());
      final loaded = cubit.state as SettingsLoaded;
      expect(loaded.profile.storeName, 'ملكة الأناقة');
      expect(loaded.isSavedSuccessfully, true);
    });
  });
}
