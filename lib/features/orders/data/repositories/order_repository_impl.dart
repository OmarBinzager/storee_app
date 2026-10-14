import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<CustomerOrder>>> getOrders() async {
    try {
      final orders = await localDataSource.getOrders();
      return Right(orders);
    } catch (e) {
      return Left(DatabaseFailure('فشل في استرجاع قائمة الطلبات: $e'));
    }
  }

  @override
  Future<Either<Failure, CustomerOrder>> createOrder(CustomerOrder order) async {
    try {
      final created = await localDataSource.createOrder(order);
      return Right(created);
    } catch (e) {
      return Left(DatabaseFailure('فشل في إنشاء الطلب: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateOrderStatus(String orderId, OrderExecutionStatus newStatus) async {
    try {
      await localDataSource.updateOrderStatus(orderId, newStatus);
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('فشل في تحديث حالة الطلب: $e'));
    }
  }
}
