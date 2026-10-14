import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/license_repository.dart';
import 'license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  final LicenseRepository repository;

  LicenseCubit(this.repository) : super(LicenseInitial());

  Future<void> checkLicense() async {
    emit(LicenseLoading());
    final result = await repository.getActiveLicense();
    result.fold(
      (failure) => emit(LicenseError(failure.message)),
      (license) => emit(LicenseLoaded(license)),
    );
  }

  Future<bool> activateKey(String key, {String? clientName}) async {
    emit(LicenseLoading());
    final result = await repository.activateLicense(key, clientName: clientName);
    return result.fold(
      (failure) {
        emit(LicenseError(failure.message));
        return false;
      },
      (license) {
        emit(LicenseActivationSuccess(license, 'تم تفعيل ترخيص ستوري بنجاح! شكراً لثقتكِ.'));
        return true;
      },
    );
  }
}
