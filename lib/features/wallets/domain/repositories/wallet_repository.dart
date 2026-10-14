import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/money.dart';
import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, List<Wallet>>> getWallets();
  Future<Either<Failure, Wallet>> createWallet({
    required String name,
    required WalletType type,
  });
  Future<Either<Failure, List<FinancialTransaction>>> getRecentTransactions({int limit = 30});

  /// Records a customer payment, allocates it across orders, updates order paid amounts and wallet balances atomically
  Future<Either<Failure, Unit>> recordPayment({
    required String customerId,
    required String walletId,
    required Money amount,
    required List<({String orderId, Money allocatedAmount})> allocations,
    String? notes,
  });

  /// Records an operational expense (deducted from operating profits)
  Future<Either<Failure, Unit>> recordExpense({
    required String walletId,
    required Money amount,
    required String category,
    String? orderId,
    String? purchaseBatchId,
    String? notes,
  });

  /// Records an owner personal withdrawal (strictly separated from operational expenses)
  Future<Either<Failure, Unit>> recordPersonalWithdrawal({
    required String walletId,
    required Money amount,
    String? notes,
  });

  /// Records an internal transfer between two wallets (not an income, not an expense)
  Future<Either<Failure, Unit>> recordTransfer({
    required String fromWalletId,
    required String toWalletId,
    required Money amount,
    String? notes,
  });
}
