import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/security_repository.dart';
import 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  final SecurityRepository repository;

  SecurityCubit(this.repository) : super(SecurityInitial());

  Future<void> checkSecurityStatus() async {
    emit(SecurityLoading());
    final result = await repository.getSecuritySettings();
    result.fold(
      (failure) => emit(SecurityError(failure.message)),
      (settings) {
        if (!settings.isPinEnabled || settings.isUnlocked) {
          emit(SecurityUnlocked(isPinEnabled: settings.isPinEnabled));
        } else {
          emit(const SecurityLocked());
        }
      },
    );
  }

  Future<bool> unlockWithPin(String pin) async {
    final result = await repository.verifyPin(pin);
    return result.fold(
      (failure) {
        emit(SecurityLocked(
          failedAttempts: (state is SecurityLocked) ? (state as SecurityLocked).failedAttempts + 1 : 1,
          errorMessage: failure.message,
        ));
        return false;
      },
      (isValid) {
        if (isValid) {
          emit(const SecurityUnlocked(isPinEnabled: true));
          return true;
        } else {
          final attempts = (state is SecurityLocked) ? (state as SecurityLocked).failedAttempts + 1 : 1;
          emit(SecurityLocked(
            failedAttempts: attempts,
            errorMessage: 'رمز المرور غير صحيح. يرجى المحاولة مجدداً.',
          ));
          return false;
        }
      },
    );
  }

  Future<bool> enablePin(String newPin) async {
    final result = await repository.setPin(newPin);
    return result.fold(
      (failure) {
        emit(SecurityError(failure.message));
        return false;
      },
      (_) {
        emit(const SecurityUnlocked(isPinEnabled: true));
        return true;
      },
    );
  }

  Future<bool> disablePin() async {
    final result = await repository.disablePin();
    return result.fold(
      (failure) {
        emit(SecurityError(failure.message));
        return false;
      },
      (_) {
        emit(const SecurityUnlocked(isPinEnabled: false));
        return true;
      },
    );
  }
}
