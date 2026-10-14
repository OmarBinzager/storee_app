import 'package:equatable/equatable.dart';

class AppLicense extends Equatable {
  final String licenseKey;
  final String clientName;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final int gracePeriodDays;
  final bool isTrial;

  const AppLicense({
    required this.licenseKey,
    required this.clientName,
    required this.issuedAt,
    required this.expiresAt,
    this.gracePeriodDays = 7,
    this.isTrial = false,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  bool get isInGracePeriod {
    final now = DateTime.now();
    final graceDeadline = expiresAt.add(Duration(days: gracePeriodDays));
    return now.isAfter(expiresAt) && now.isBefore(graceDeadline);
  }

  bool get isValid => !isExpired || isInGracePeriod;

  int get remainingDays {
    final now = DateTime.now();
    if (isExpired) return 0;
    return expiresAt.difference(now).inDays;
  }

  int get remainingGraceDays {
    if (!isInGracePeriod) return 0;
    final now = DateTime.now();
    final graceDeadline = expiresAt.add(Duration(days: gracePeriodDays));
    return graceDeadline.difference(now).inDays + 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'licenseKey': licenseKey,
      'clientName': clientName,
      'issuedAt': issuedAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'gracePeriodDays': gracePeriodDays,
      'isTrial': isTrial,
    };
  }

  factory AppLicense.fromJson(Map<String, dynamic> json) {
    return AppLicense(
      licenseKey: json['licenseKey'] as String,
      clientName: json['clientName'] as String? ?? 'تاجر ستوري',
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      gracePeriodDays: json['gracePeriodDays'] as int? ?? 7,
      isTrial: json['isTrial'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        licenseKey,
        clientName,
        issuedAt,
        expiresAt,
        gracePeriodDays,
        isTrial,
      ];
}
