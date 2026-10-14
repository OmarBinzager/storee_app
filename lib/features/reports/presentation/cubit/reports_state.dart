import 'package:equatable/equatable.dart';
import '../../../../core/money/currency.dart';
import '../../domain/entities/financial_report.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final FinancialReport currentReport;
  final Currency selectedCurrency;
  final Map<String, FinancialReport> allCurrenciesReport;

  const ReportsLoaded({
    required this.currentReport,
    required this.selectedCurrency,
    required this.allCurrenciesReport,
  });

  @override
  List<Object?> get props => [currentReport, selectedCurrency, allCurrenciesReport];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object?> get props => [message];
}
