import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer_order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<CustomerOrder>>> getOrders();
  Future<Either<Failure, CustomerOrder>> createOrder(CustomerOrder order);
  Future<Either<Failure, Unit>> updateOrderStatus(String orderId, OrderExecutionStatus newStatus);
}
