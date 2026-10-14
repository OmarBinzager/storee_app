import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_license.dart';
import '../../domain/repositories/license_repository.dart';
import '../datasources/license_local_datasource.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  final LicenseLocalDataSource localDataSource;

  LicenseRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AppLicense>> getActiveLicense() async {
    try {
      final license = await localDataSource.getActiveLicense();
      return Right(license);
    } catch (e) {
      return Left(DatabaseFailure('فشل قراءة بيانات الترخيص: $e'));
    }
  }

  @override
  Future<Either<Failure, AppLicense>> activateLicense(String licenseKey, {String? clientName}) async {
    try {
      final license = await localDataSource.activateLicense(licenseKey, clientName: clientName);
      return Right(license);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('فشل تفعيل الترخيص: $e'));
    }
  }

  @override
  Future<Either<Failure, AppLicense>> startTrial({String? clientName}) async {
    try {
      final license = await localDataSource.startTrial(clientName: clientName);
      return Right(license);
    } catch (e) {
      return Left(DatabaseFailure('فشل بدء الفترة التجريبية: $e'));
    }
  }
}
