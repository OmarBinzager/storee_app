import 'package:equatable/equatable.dart';
import '../../domain/entities/store_profile.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final StoreProfile profile;
  final bool isSavedSuccessfully;

  const SettingsLoaded({
    required this.profile,
    this.isSavedSuccessfully = false,
  });

  SettingsLoaded copyWith({
    StoreProfile? profile,
    bool? isSavedSuccessfully,
  }) {
    return SettingsLoaded(
      profile: profile ?? this.profile,
      isSavedSuccessfully: isSavedSuccessfully ?? false,
    );
  }

  @override
  List<Object?> get props => [profile, isSavedSuccessfully];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
