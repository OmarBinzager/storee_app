import 'package:equatable/equatable.dart';
import '../../domain/entities/app_license.dart';

sealed class LicenseState extends Equatable {
  const LicenseState();

  @override
  List<Object?> get props => [];
}

class LicenseInitial extends LicenseState {}

class LicenseLoading extends LicenseState {}

class LicenseLoaded extends LicenseState {
  final AppLicense license;

  const LicenseLoaded(this.license);

  @override
  List<Object?> get props => [license];
}

class LicenseActivationSuccess extends LicenseState {
  final AppLicense license;
  final String message;

  const LicenseActivationSuccess(this.license, this.message);

  @override
  List<Object?> get props => [license, message];
}

class LicenseError extends LicenseState {
  final String message;

  const LicenseError(this.message);

  @override
  List<Object?> get props => [message];
}
