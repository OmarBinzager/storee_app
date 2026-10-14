import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'حدث خطأ في قاعدة البيانات']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class CurrencyMismatchFailure extends Failure {
  const CurrencyMismatchFailure([super.message = 'لا يمكن إجراء العمليات الحسابية بين عملات مختلفة دون تحويل مسبق']);
}

class InsufficientBalanceFailure extends Failure {
  const InsufficientBalanceFailure([super.message = 'رصيد الخزنة غير كافٍ لإتمام الحركة']);
}

class BackupFailure extends Failure {
  const BackupFailure([super.message = 'فشلت عملية النسخ الاحتياطي أو الاستعادة']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'العنصر المطلوب غير موجود']);
}
