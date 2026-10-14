import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/money/currency.dart';
import '../entities/financial_report.dart';

abstract class ReportsRepository {
  Future<Either<Failure, FinancialReport>> getFinancialReport({
    required Currency currency,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<Either<Failure, Map<String, FinancialReport>>> getAllCurrenciesSummary();
}
