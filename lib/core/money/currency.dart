import 'package:equatable/equatable.dart';

/// Supported Currencies according to Storee specifications.
class Currency extends Equatable {
  final String code; // e.g. YER, SAR, USD
  final String nameAr; // e.g. ريال يمني
  final String symbolAr; // e.g. ر.ي
  final int minorUnitDigits; // Decimal precision (YER: 0, SAR: 2, USD: 2)

  const Currency({
    required this.code,
    required this.nameAr,
    required this.symbolAr,
    required this.minorUnitDigits,
  });

  static const Currency yer = Currency(
    code: 'YER',
    nameAr: 'ريال يمني',
    symbolAr: 'ر.ي',
    minorUnitDigits: 0,
  );

  static const Currency sar = Currency(
    code: 'SAR',
    nameAr: 'ريال سعودي',
    symbolAr: 'ر.س',
    minorUnitDigits: 2,
  );

  static const Currency usd = Currency(
    code: 'USD',
    nameAr: 'دولار أمريكي',
    symbolAr: r'$',
    minorUnitDigits: 2,
  );

  static const List<Currency> values = [yer, sar, usd];

  static Currency fromCode(String code) {
    return values.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => yer,
    );
  }

  @override
  List<Object?> get props => [code, nameAr, symbolAr, minorUnitDigits];
}
