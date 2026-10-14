import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/money/currency.dart';
import '../../domain/repositories/reports_repository.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsRepository repository;

  ReportsCubit(this.repository) : super(ReportsInitial());

  Future<void> loadReports({Currency currency = Currency.sar}) async {
    emit(ReportsLoading());

    final reportResult = await repository.getFinancialReport(currency: currency);
    final allResult = await repository.getAllCurrenciesSummary();

    reportResult.fold(
      (failure) => emit(ReportsError(failure.message)),
      (currentReport) {
        allResult.fold(
          (failure) => emit(ReportsLoaded(
            currentReport: currentReport,
            selectedCurrency: currency,
            allCurrenciesReport: {currency.code: currentReport},
          )),
          (allSummaries) => emit(ReportsLoaded(
            currentReport: currentReport,
            selectedCurrency: currency,
            allCurrenciesReport: allSummaries,
          )),
        );
      },
    );
  }

  void switchCurrency(Currency currency) {
    loadReports(currency: currency);
  }
}
