import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storee/features/security/data/datasources/security_local_datasource.dart';
import 'package:storee/features/security/data/repositories/security_repository_impl.dart';
import 'package:storee/features/security/presentation/cubit/security_cubit.dart';
import 'package:storee/features/security/presentation/cubit/security_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences prefs;
  late SecurityLocalDataSource localDataSource;
  late SecurityRepositoryImpl repository;
  late SecurityCubit cubit;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    localDataSource = SecurityLocalDataSourceImpl(prefs);
    repository = SecurityRepositoryImpl(localDataSource);
    cubit = SecurityCubit(repository);
  });

  tearDown(() {
    cubit.close();
  });

  group('SecurityRepository & SecurityCubit Tests', () {
    test('default status is unlocked when PIN is not enabled', () async {
      final result = await repository.getSecuritySettings();
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Expected right'),
        (settings) {
          expect(settings.isPinEnabled, false);
          expect(settings.isUnlocked, true);
        },
      );
    });

    test('sets 4-digit PIN and verifies successfully with correct code', () async {
      final setResult = await repository.setPin('1234');
      expect(setResult.isRight(), true);

      final verifyCorrect = await repository.verifyPin('1234');
      expect(verifyCorrect.isRight(), true);
      verifyCorrect.fold(
        (_) => fail('Expected right'),
        (isValid) => expect(isValid, true),
      );

      final verifyWrong = await repository.verifyPin('9999');
      expect(verifyWrong.isRight(), true);
      verifyWrong.fold(
        (_) => fail('Expected right'),
        (isValid) => expect(isValid, false),
      );
    });

    test('rejects PIN with length not equal to 4 digits', () async {
      final result = await repository.setPin('12');
      expect(result.isLeft(), true);
    });

    test('disables PIN and clears lock status', () async {
      await repository.setPin('4321');
      final disableResult = await repository.disablePin();
      expect(disableResult.isRight(), true);

      final settings = await repository.getSecuritySettings();
      settings.fold(
        (_) => fail('Expected right'),
        (s) => expect(s.isPinEnabled, false),
      );
    });

    test('SecurityCubit enables PIN, detects lock status, and unlocks with PIN', () async {
      final enabled = await cubit.enablePin('5678');
      expect(enabled, true);
      expect(cubit.state, const SecurityUnlocked(isPinEnabled: true));

      // Simulate locked app state by creating fresh repository with locked session
      final freshRepo = SecurityRepositoryImpl(localDataSource);
      final freshCubit = SecurityCubit(freshRepo);

      await freshCubit.checkSecurityStatus();
      expect(freshCubit.state, isA<SecurityLocked>());

      // Attempt wrong PIN
      final wrongSuccess = await freshCubit.unlockWithPin('0000');
      expect(wrongSuccess, false);
      expect(freshCubit.state, isA<SecurityLocked>());
      expect((freshCubit.state as SecurityLocked).failedAttempts, 1);

      // Attempt correct PIN
      final rightSuccess = await freshCubit.unlockWithPin('5678');
      expect(rightSuccess, true);
      expect(freshCubit.state, const SecurityUnlocked(isPinEnabled: true));

      freshCubit.close();
    });
  });
}
