import 'package:equatable/equatable.dart';

class SecuritySettings extends Equatable {
  final bool isPinEnabled;
  final bool isUnlocked;

  const SecuritySettings({
    required this.isPinEnabled,
    required this.isUnlocked,
  });

  SecuritySettings copyWith({
    bool? isPinEnabled,
    bool? isUnlocked,
  }) {
    return SecuritySettings(
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  @override
  List<Object?> get props => [isPinEnabled, isUnlocked];
}
