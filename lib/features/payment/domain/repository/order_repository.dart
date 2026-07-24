import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/order_payment_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderPaymentEntity>> createOrder(int propertyId);
}

