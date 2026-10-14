import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/backup_repository.dart';
import 'backup_state.dart';

class BackupCubit extends Cubit<BackupState> {
  final BackupRepository repository;

  BackupCubit(this.repository) : super(BackupInitial());

  Future<void> loadBackups() async {
    emit(BackupLoading());
    final result = await repository.listLocalBackups();
    result.fold(
      (failure) => emit(BackupError(failure.message)),
      (backups) => emit(BackupLoaded(backups)),
    );
  }

  Future<bool> createBackup({String? customDirectory}) async {
    emit(BackupLoading());
    final result = await repository.createBackup(customDirectory: customDirectory);
    return result.fold(
      (failure) {
        emit(BackupError(failure.message));
        return false;
      },
      (meta) {
        emit(BackupActionSuccess('تم إنشاء النسخة الاحتياطية بنجاح وحفظها محلياً', metadata: meta));
        loadBackups();
        return true;
      },
    );
  }

  Future<bool> restoreBackup(String filePath) async {
    emit(BackupLoading());
    final result = await repository.restoreBackup(filePath);
    return result.fold(
      (failure) {
        emit(BackupError(failure.message));
        return false;
      },
      (_) {
        emit(const BackupActionSuccess('تمت استعادة كافة البيانات والطلبات والحسابات بنجاح تام!'));
        loadBackups();
        return true;
      },
    );
  }
}
