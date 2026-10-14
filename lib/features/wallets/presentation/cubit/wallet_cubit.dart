import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepository repository;

  WalletCubit(this.repository) : super(WalletInitial());

  Future<void> loadWallets() async {
    emit(WalletLoading());

    final walletsResult = await repository.getWallets();
    final transactionsResult = await repository.getRecentTransactions();

    walletsResult.fold(
      (failure) => emit(WalletError(failure.message)),
      (wallets) {
        transactionsResult.fold(
          (failure) => emit(WalletLoaded(wallets: wallets, recentTransactions: const [])),
          (transactions) => emit(WalletLoaded(wallets: wallets, recentTransactions: transactions)),
        );
      },
    );
  }

  Future<bool> createWallet({required String name, required WalletType type}) async {
    final result = await repository.createWallet(name: name, type: type);
    return result.fold(
      (failure) {
        emit(WalletError(failure.message));
        return false;
      },
      (_) {
        loadWallets();
        return true;
      },
    );
  }

  Future<bool> recordPayment({
    required String customerId,
    required String walletId,
    required Money amount,
    required List<({String orderId, Money allocatedAmount})> allocations,
    String? notes,
  }) async {
    final result = await repository.recordPayment(
      customerId: customerId,
      walletId: walletId,
      amount: amount,
      allocations: allocations,
      notes: notes,
    );

    return result.fold(
      (failure) {
        emit(WalletError(failure.message));
        return false;
      },
      (_) {
        loadWallets();
        return true;
      },
    );
  }

  Future<bool> recordExpense({
    required String walletId,
    required Money amount,
    required String category,
    String? orderId,
    String? purchaseBatchId,
    String? notes,
  }) async {
    final result = await repository.recordExpense(
      walletId: walletId,
      amount: amount,
      category: category,
      orderId: orderId,
      purchaseBatchId: purchaseBatchId,
      notes: notes,
    );

    return result.fold(
      (failure) {
        emit(WalletError(failure.message));
        return false;
      },
      (_) {
        loadWallets();
        return true;
      },
    );
  }

  Future<bool> recordPersonalWithdrawal({
    required String walletId,
    required Money amount,
    String? notes,
  }) async {
    final result = await repository.recordPersonalWithdrawal(
      walletId: walletId,
      amount: amount,
      notes: notes,
    );

    return result.fold(
      (failure) {
        emit(WalletError(failure.message));
        return false;
      },
      (_) {
        loadWallets();
        return true;
      },
    );
  }

  Future<bool> recordTransfer({
    required String fromWalletId,
    required String toWalletId,
    required Money amount,
    String? notes,
  }) async {
    final result = await repository.recordTransfer(
      fromWalletId: fromWalletId,
      toWalletId: toWalletId,
      amount: amount,
      notes: notes,
    );

    return result.fold(
      (failure) {
        emit(WalletError(failure.message));
        return false;
      },
      (_) {
        loadWallets();
        return true;
      },
    );
  }
}
