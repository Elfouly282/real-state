import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/order_payment_entity.dart';
import '../repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository _repository;

  CreateOrderUseCase(this._repository);
  Future<Either<Failure, OrderPaymentEntity>> invoke(int propertyId) =>
      _repository.createOrder(propertyId);
}
