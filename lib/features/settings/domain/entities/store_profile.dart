import 'package:equatable/equatable.dart';

class StoreProfile extends Equatable {
  final String storeName;
  final String ownerPhone;
  final String customThankYou;
  final String defaultCurrencyCode;

  const StoreProfile({
    this.storeName = 'ستوري بوتيك',
    this.ownerPhone = '',
    this.customThankYou = 'شكراً لثقتكِ وتعاملكِ الراقي معنا ✨',
    this.defaultCurrencyCode = 'SAR',
  });

  StoreProfile copyWith({
    String? storeName,
    String? ownerPhone,
    String? customThankYou,
    String? defaultCurrencyCode,
  }) {
    return StoreProfile(
      storeName: storeName ?? this.storeName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      customThankYou: customThankYou ?? this.customThankYou,
      defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
    );
  }

  @override
  List<Object?> get props => [storeName, ownerPhone, customThankYou, defaultCurrencyCode];
}
