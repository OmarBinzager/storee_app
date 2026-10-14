import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/app_license.dart';

abstract class LicenseRepository {
  Future<Either<Failure, AppLicense>> getActiveLicense();
  Future<Either<Failure, AppLicense>> activateLicense(String licenseKey, {String? clientName});
  Future<Either<Failure, AppLicense>> startTrial({String? clientName});
}
