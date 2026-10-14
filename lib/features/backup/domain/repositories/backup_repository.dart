import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/backup_metadata.dart';

abstract class BackupRepository {
  Future<Either<Failure, BackupMetadata>> createBackup({String? customDirectory});
  Future<Either<Failure, BackupMetadata>> inspectBackup(String filePath);
  Future<Either<Failure, void>> restoreBackup(String filePath);
  Future<Either<Failure, List<BackupMetadata>>> listLocalBackups();
}
