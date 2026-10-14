import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource localDataSource;

  WalletRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Wallet>>> getWallets() async {
    try {
      final wallets = await localDataSource.getWallets();
      return Right(wallets);
    } catch (e) {
      return Left(DatabaseFailure('فشل في جلب قائمة الخزنات: $e'));
    }
  }

  @override
  Future<Either<Failure, Wallet>> createWallet({
    required String name,
    required WalletType type,
  }) async {
    try {
      final wallet = await localDataSource.createWallet(name: name, type: type);
      return Right(wallet);
    } catch (e) {
      return Left(DatabaseFailure('فشل في إنشاء الخزنة: $e'));
    }
  }

  @override
  Future<Either<Failure, List<FinancialTransaction>>> getRecentTransactions({int limit = 30}) async {
    try {
      final transactions = await localDataSource.getRecentTransactions(limit: limit);
      return Right(transactions);
    } catch (e) {
      return Left(DatabaseFailure('فشل في جلب سجل الحركات المالية: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> recordPayment({
    required String customerId,
    required String walletId,
    required Money amount,
    required List<({String orderId, Money allocatedAmount})> allocations,
    String? notes,
  }) async {
    try {
      await localDataSource.recordPayment(
        customerId: customerId,
        walletId: walletId,
        amount: amount,
        allocations: allocations,
        notes: notes,
      );
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تسجيل الدفعة وتخصيصها: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> recordExpense({
    required String walletId,
    required Money amount,
    required String category,
    String? orderId,
    String? purchaseBatchId,
    String? notes,
  }) async {
    try {
      await localDataSource.recordExpense(
        walletId: walletId,
        amount: amount,
        category: category,
        orderId: orderId,
        purchaseBatchId: purchaseBatchId,
        notes: notes,
      );
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تسجيل المصروف: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> recordPersonalWithdrawal({
    required String walletId,
    required Money amount,
    String? notes,
  }) async {
    try {
      await localDataSource.recordPersonalWithdrawal(
        walletId: walletId,
        amount: amount,
        notes: notes,
      );
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تسجيل السحب الشخصي: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> recordTransfer({
    required String fromWalletId,
    required String toWalletId,
    required Money amount,
    String? notes,
  }) async {
    try {
      await localDataSource.recordTransfer(
        fromWalletId: fromWalletId,
        toWalletId: toWalletId,
        amount: amount,
        notes: notes,
      );
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تحويل الأموال بين الخزنات: $e'));
    }
  }
}
