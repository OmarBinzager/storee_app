import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_local_datasource.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Customer>>> getCustomers() async {
    try {
      final customers = await localDataSource.getCustomers();
      return Right(customers);
    } catch (e) {
      return Left(DatabaseFailure('فشل في جلب قائمة العميلات: $e'));
    }
  }

  @override
  Future<Either<Failure, Customer>> addCustomer(Customer customer) async {
    try {
      final created = await localDataSource.addCustomer(customer);
      return Right(created);
    } catch (e) {
      return Left(DatabaseFailure('فشل في إضافة العميلة: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomer(Customer customer) async {
    try {
      await localDataSource.updateCustomer(customer);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تعديل بيانات العميلة: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> archiveCustomer(String id) async {
    try {
      await localDataSource.archiveCustomer(id);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في أرشفة العميلة: $e'));
    }
  }
}
