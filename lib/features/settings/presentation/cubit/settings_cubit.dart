import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/store_profile.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit(this.repository) : super(SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    final result = await repository.getStoreProfile();
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (profile) => emit(SettingsLoaded(profile: profile)),
    );
  }

  Future<bool> updateSettings(StoreProfile newProfile) async {
    final result = await repository.saveStoreProfile(newProfile);
    return result.fold(
      (failure) {
        emit(SettingsError(failure.message));
        return false;
      },
      (_) {
        emit(SettingsLoaded(profile: newProfile, isSavedSuccessfully: true));
        return true;
      },
    );
  }
}
