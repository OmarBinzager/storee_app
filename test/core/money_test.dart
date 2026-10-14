import 'package:flutter_test/flutter_test.dart';
import 'package:storee/core/money/currency.dart';
import 'package:storee/core/money/money.dart';

void main() {
  group('Money Value Object Tests', () {
    test('accurately calculates minor units without double precision drift', () {
      final sarMoney = Money.fromMajor(10.50, Currency.sar);
      expect(sarMoney.amountMinor, 1050);
      expect(sarMoney.toMajor, 10.50);

      final yerMoney = Money.fromMajor(25000, Currency.yer);
      expect(yerMoney.amountMinor, 25000);
      expect(yerMoney.toMajor, 25000.0);
    });

    test('adds and subtracts money of same currency correctly', () {
      final a = Money.fromMajor(50, Currency.sar);
      final b = Money.fromMajor(30, Currency.sar);

      final sum = a + b;
      expect(sum.amountMinor, 8000); // 80.00 SAR
      expect(sum.toMajor, 80.0);

      final diff = a - b;
      expect(diff.amountMinor, 2000); // 20.00 SAR
      expect(diff.toMajor, 20.0);
    });

    test('throws CurrencyMismatchException when combining YER and SAR directly', () {
      final yerMoney = Money.fromMajor(1000, Currency.yer);
      final sarMoney = Money.fromMajor(10, Currency.sar);

      expect(() => yerMoney + sarMoney, throwsA(isA<CurrencyMismatchException>()));
      expect(() => yerMoney - sarMoney, throwsA(isA<CurrencyMismatchException>()));
    });
  });
}
