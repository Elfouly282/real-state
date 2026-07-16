import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUsecase {
  final OrdersRepository _repo;
  GetOrdersUsecase(this._repo);
  Future<Either<Failure, List<OrderEntity>>> call() => _repo.getOrders();
}

class GetOrderUsecase {
  final OrdersRepository _repo;
  GetOrderUsecase(this._repo);
  Future<Either<Failure, OrderEntity>> call(int id) => _repo.getOrder(id);
}
