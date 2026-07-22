import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, PaginatedOrdersEntity>> getOrders({
    int perPage = 30,
    int page = 1,
    String? status,
  });
  Future<Either<Failure, OrderEntity>> getOrder(int id);
}
