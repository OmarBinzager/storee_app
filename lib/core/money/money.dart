import 'dart:math' as math;
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'currency.dart';

/// Thrown when attempting an arithmetic operation between two incompatible currencies.
class CurrencyMismatchException implements Exception {
  final String sourceCurrency;
  final String targetCurrency;

  CurrencyMismatchException(this.sourceCurrency, this.targetCurrency);

  @override
  String toString() =>
      'CurrencyMismatchException: Cannot operate between $sourceCurrency and $targetCurrency without explicit conversion.';
}

/// Represents an exact monetary amount in its lowest subunit (Minor Unit),
/// preventing floating point rounding errors in financial transactions.
class Money extends Equatable implements Comparable<Money> {
  final int amountMinor;
  final Currency currency;

  const Money({
    required this.amountMinor,
    required this.currency,
  });

  /// Factory from major units (e.g. 10.50 SAR -> 1050 minor units)
  factory Money.fromMajor(num amountMajor, Currency currency) {
    final factor = math.pow(10, currency.minorUnitDigits).toInt();
    final minor = (amountMajor * factor).round();
    return Money(amountMinor: minor, currency: currency);
  }

  /// Zero amount for a given currency
  factory Money.zero(Currency currency) => Money(amountMinor: 0, currency: currency);

  /// Converts minor units back to human-readable major decimal for display
  double get toMajor {
    if (currency.minorUnitDigits == 0) return amountMinor.toDouble();
    return amountMinor / math.pow(10, currency.minorUnitDigits);
  }

  bool get isZero => amountMinor == 0;
  bool get isPositive => amountMinor > 0;
  bool get isNegative => amountMinor < 0;

  Money operator +(Money other) {
    _ensureSameCurrency(other);
    return Money(
      amountMinor: amountMinor + other.amountMinor,
      currency: currency,
    );
  }

  Money operator -(Money other) {
    _ensureSameCurrency(other);
    return Money(
      amountMinor: amountMinor - other.amountMinor,
      currency: currency,
    );
  }

  Money operator *(num multiplier) {
    return Money(
      amountMinor: (amountMinor * multiplier).round(),
      currency: currency,
    );
  }

  Money allocatePercentage(double percentage) {
    return Money(
      amountMinor: (amountMinor * (percentage / 100.0)).round(),
      currency: currency,
    );
  }

  void _ensureSameCurrency(Money other) {
    if (currency.code != other.currency.code) {
      throw CurrencyMismatchException(currency.code, other.currency.code);
    }
  }

  /// Formats the money string for Arabic display (e.g. "1,250 ر.س" or "25,000 ر.ي")
  String format({bool includeSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'ar',
      symbol: includeSymbol ? currency.symbolAr : '',
      decimalDigits: currency.minorUnitDigits,
    );
    return formatter.format(toMajor).trim();
  }

  @override
  int compareTo(Money other) {
    _ensureSameCurrency(other);
    return amountMinor.compareTo(other.amountMinor);
  }

  @override
  List<Object?> get props => [amountMinor, currency];

  @override
  String toString() => '${format()} (${currency.code})';
}
