import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/security_settings.dart';

abstract class SecurityRepository {
  Future<Either<Failure, SecuritySettings>> getSecuritySettings();
  Future<Either<Failure, Unit>> setPin(String pin);
  Future<Either<Failure, Unit>> disablePin();
  Future<Either<Failure, bool>> verifyPin(String pin);
}
