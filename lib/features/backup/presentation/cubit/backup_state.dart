import 'package:equatable/equatable.dart';
import '../../domain/entities/backup_metadata.dart';

sealed class BackupState extends Equatable {
  const BackupState();

  @override
  List<Object?> get props => [];
}

class BackupInitial extends BackupState {}

class BackupLoading extends BackupState {}

class BackupActionSuccess extends BackupState {
  final String message;
  final BackupMetadata? metadata;

  const BackupActionSuccess(this.message, {this.metadata});

  @override
  List<Object?> get props => [message, metadata];
}

class BackupLoaded extends BackupState {
  final List<BackupMetadata> backups;

  const BackupLoaded(this.backups);

  @override
  List<Object?> get props => [backups];
}

class BackupError extends BackupState {
  final String message;

  const BackupError(this.message);

  @override
  List<Object?> get props => [message];
}
