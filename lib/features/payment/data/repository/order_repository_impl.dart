import 'package:dartz/dartz.dart';
import 'package:real_state/features/payment/data/data_source/order_remote_data_source.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entity/order_payment_entity.dart';
import '../../domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, OrderPaymentEntity>> createOrder(
    int propertyId,
  ) async {
    try {
      final response = await _remoteDataSource.createOrder(propertyId);
      return Right(response.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
