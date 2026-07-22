import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUsecase {
  final OrdersRepository _repo;
  GetOrdersUsecase(this._repo);
  Future<Either<Failure, PaginatedOrdersEntity>> call({
    int perPage = 30,
    int page = 1,
    String? status,
  }) =>
      _repo.getOrders(perPage: perPage, page: page, status: status);
}

class GetOrderUsecase {
  final OrdersRepository _repo;
  GetOrderUsecase(this._repo);
  Future<Either<Failure, OrderEntity>> call(int id) => _repo.getOrder(id);
}
