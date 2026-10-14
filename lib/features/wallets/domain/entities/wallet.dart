import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';

enum WalletType {
  cash,
  bankAccount,
  electronicWallet,
  custom;

  String get labelAr => switch (this) {
        WalletType.cash => 'كاش',
        WalletType.bankAccount => 'حساب بنكي',
        WalletType.electronicWallet => 'محفظة إلكترونية',
        WalletType.custom => 'خزنة مخصصة',
      };
}

enum TransactionType {
  paymentReceived, // قبض من عميلة
  refundIssued, // استرداد لعميلة
  supplierPayment, // دفع لمورد
  operationalExpense, // مصروف تشغيلي
  personalWithdrawal, // سحب شخصي للمالكة (منفصل تماماً عن المصاريف التشغيلية)
  transferIn, // تحويل وارد (ليس دخلاً)
  transferOut, // تحويل صادر (ليس مصروفاً)
  adjustment, // تسوية
}

class FinancialTransaction extends Equatable {
  final String id;
  final TransactionType type;
  final String walletId;
  final Money amount;
  final DateTime occurredAt;
  final String? referenceId; // orderId, customerId, batchId, transferId
  final String? notes;

  const FinancialTransaction({
    required this.id,
    required this.type,
    required this.walletId,
    required this.amount,
    required this.occurredAt,
    this.referenceId,
    this.notes,
  });

  @override
  List<Object?> get props => [id, type, walletId, amount, occurredAt, referenceId, notes];
}

class Wallet extends Equatable {
  final String id;
  final String name;
  final WalletType type;
  final bool isActive;
  // Multi-currency balances: e.g. YER: Money(50000), SAR: Money(450)
  final Map<String, Money> balances;

  const Wallet({
    required this.id,
    required this.name,
    required this.type,
    this.isActive = true,
    required this.balances,
  });

  Money getBalanceFor(Currency currency) {
    return balances[currency.code] ?? Money.zero(currency);
  }

  @override
  List<Object?> get props => [id, name, type, isActive, balances];
}
