import 'package:equatable/equatable.dart';
import 'currency.dart';
import 'money.dart';

/// Represents an explicit recorded exchange rate between two currencies.
class ExchangeRate extends Equatable {
  final String id;
  final Currency fromCurrency;
  final Currency toCurrency;
  final double rateDecimal; // e.g. 1 SAR = 430 YER
  final DateTime effectiveAt;
  final String? source;

  const ExchangeRate({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rateDecimal,
    required this.effectiveAt,
    this.source,
  });

  /// Converts a source Money object to target currency using this exchange rate.
  Money convert(Money sourceMoney) {
    if (sourceMoney.currency.code != fromCurrency.code) {
      throw CurrencyMismatchException(sourceMoney.currency.code, fromCurrency.code);
    }
    final convertedMajor = sourceMoney.toMajor * rateDecimal;
    return Money.fromMajor(convertedMajor, toCurrency);
  }

  @override
  List<Object?> get props => [id, fromCurrency, toCurrency, rateDecimal, effectiveAt, source];
}
