import 'package:equatable/equatable.dart';

sealed class SecurityState extends Equatable {
  const SecurityState();

  @override
  List<Object?> get props => [];
}

class SecurityInitial extends SecurityState {}

class SecurityLoading extends SecurityState {}

class SecurityUnlocked extends SecurityState {
  final bool isPinEnabled;

  const SecurityUnlocked({required this.isPinEnabled});

  @override
  List<Object?> get props => [isPinEnabled];
}

class SecurityLocked extends SecurityState {
  final int failedAttempts;
  final String? errorMessage;

  const SecurityLocked({
    this.failedAttempts = 0,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [failedAttempts, errorMessage];
}

class SecurityError extends SecurityState {
  final String message;
  const SecurityError(this.message);

  @override
  List<Object?> get props => [message];
}
