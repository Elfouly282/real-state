import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, OrderEntity>> getOrder(int id);
}
