import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/wallet.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  void loadWallets() {
    emit(WalletLoading());

    final wallets = [
      Wallet(
        id: 'w1',
        name: 'الكاش الشخصي',
        type: WalletType.cash,
        balances: {
          'YER': Money.fromMajor(450000, Currency.yer),
          'SAR': Money.fromMajor(1200, Currency.sar),
        },
      ),
      Wallet(
        id: 'w2',
        name: 'محفظة جيب / ون كاش',
        type: WalletType.electronicWallet,
        balances: {
          'YER': Money.fromMajor(280000, Currency.yer),
          'SAR': Money.zero(Currency.sar),
        },
      ),
      Wallet(
        id: 'w3',
        name: 'حساب بنك الكريمي',
        type: WalletType.bankAccount,
        balances: {
          'YER': Money.fromMajor(950000, Currency.yer),
          'SAR': Money.fromMajor(3400, Currency.sar),
        },
      ),
    ];

    final transactions = [
      FinancialTransaction(
        id: 'tx-1',
        type: TransactionType.paymentReceived,
        walletId: 'w1',
        amount: Money.fromMajor(100, Currency.sar),
        occurredAt: DateTime.now().subtract(const Duration(hours: 3)),
        notes: 'عربون طلبية فاطمة الكاف #1042',
      ),
      FinancialTransaction(
        id: 'tx-2',
        type: TransactionType.operationalExpense,
        walletId: 'w2',
        amount: Money.fromMajor(4000, Currency.yer),
        occurredAt: DateTime.now().subtract(const Duration(days: 1)),
        notes: 'أكياس وتغليف هدايا للمتجر',
      ),
      FinancialTransaction(
        id: 'tx-3',
        type: TransactionType.personalWithdrawal,
        walletId: 'w3',
        amount: Money.fromMajor(500, Currency.sar),
        occurredAt: DateTime.now().subtract(const Duration(days: 3)),
        notes: 'سحب شخصي للمالكة (خارج حسابات التشغيل)',
      ),
    ];

    emit(WalletLoaded(
      wallets: wallets,
      recentTransactions: transactions,
    ));
  }
}
