import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/currency.dart';
import '../../domain/entities/financial_report.dart';
import '../../domain/repositories/reports_repository.dart';
import '../datasources/reports_local_datasource.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsLocalDataSource localDataSource;

  ReportsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, FinancialReport>> getFinancialReport({
    required Currency currency,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final report = await localDataSource.getFinancialReport(
        currency: currency,
        fromDate: fromDate,
        toDate: toDate,
      );
      return Right(report);
    } catch (e) {
      return Left(DatabaseFailure('فشل في استخراج التقرير المالي: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, FinancialReport>>> getAllCurrenciesSummary() async {
    try {
      final summary = await localDataSource.getAllCurrenciesSummary();
      return Right(summary);
    } catch (e) {
      return Left(DatabaseFailure('فشل في استخراج ملخص التقارير لجميع العملات: $e'));
    }
  }
}
