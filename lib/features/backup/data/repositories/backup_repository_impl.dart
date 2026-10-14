import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/backup_metadata.dart';
import '../../domain/repositories/backup_repository.dart';
import '../datasources/backup_local_datasource.dart';

class BackupRepositoryImpl implements BackupRepository {
  final BackupLocalDataSource localDataSource;

  BackupRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, BackupMetadata>> createBackup({String? customDirectory}) async {
    try {
      final metadata = await localDataSource.createBackup(customDirectory: customDirectory);
      return Right(metadata);
    } catch (e) {
      return Left(BackupFailure('فشل إنشاء النسخة الاحتياطية: $e'));
    }
  }

  @override
  Future<Either<Failure, BackupMetadata>> inspectBackup(String filePath) async {
    try {
      final metadata = await localDataSource.inspectBackup(filePath);
      return Right(metadata);
    } on BackupException catch (e) {
      return Left(BackupFailure(e.message));
    } catch (e) {
      return Left(BackupFailure('فشل فحص النسخة الاحتياطية: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> restoreBackup(String filePath) async {
    try {
      await localDataSource.restoreBackup(filePath);
      return const Right(null);
    } on BackupException catch (e) {
      return Left(BackupFailure(e.message));
    } catch (e) {
      return Left(BackupFailure('فشل استعادة النسخة الاحتياطية: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BackupMetadata>>> listLocalBackups() async {
    try {
      final list = await localDataSource.listLocalBackups();
      return Right(list);
    } catch (e) {
      return Left(BackupFailure('فشل جلب قائمة النسخ الاحتياطية: $e'));
    }
  }
}
