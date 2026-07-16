import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDatasource _remote;
  final NetworkInfo _network;

  OrdersRepositoryImpl({required OrdersRemoteDatasource remote, required NetworkInfo network})
      : _remote = remote, _network = network;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() fn) async {
    if (!await _network.isConnected) return Left(NoInternetFailure(message: 'لا يوجد اتصال'));
    try { return Right(await fn()); }
    on ServerException catch (e) { return Left(ApiFailure(message: e.message)); }
    catch (e) { return Left(ServiceFailure(message: e.toString())); }
  }

  @override Future<Either<Failure, List<OrderEntity>>> getOrders() => _run(_remote.getOrders);
  @override Future<Either<Failure, OrderEntity>> getOrder(int id) => _run(() => _remote.getOrder(id));
}
