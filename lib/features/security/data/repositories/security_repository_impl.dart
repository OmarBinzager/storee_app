import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/security_settings.dart';
import '../../domain/repositories/security_repository.dart';
import '../datasources/security_local_datasource.dart';

class SecurityRepositoryImpl implements SecurityRepository {
  final SecurityLocalDataSource localDataSource;
  bool _isSessionUnlocked = false;

  SecurityRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, SecuritySettings>> getSecuritySettings() async {
    try {
      final isEnabled = await localDataSource.isPinEnabled();
      // If PIN is not enabled, the session is always considered unlocked
      final unlocked = !isEnabled || _isSessionUnlocked;
      return Right(SecuritySettings(isPinEnabled: isEnabled, isUnlocked: unlocked));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setPin(String pin) async {
    try {
      if (pin.length != 4) {
        return const Left(ValidationFailure('رمز المرور يجب أن يتكون من 4 أرقام'));
      }
      await localDataSource.savePin(pin);
      _isSessionUnlocked = true;
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disablePin() async {
    try {
      await localDataSource.removePin();
      _isSessionUnlocked = true;
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPin(String pin) async {
    try {
      final isValid = await localDataSource.checkPin(pin);
      if (isValid) {
        _isSessionUnlocked = true;
      }
      return Right(isValid);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
