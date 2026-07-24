import 'package:real_state/features/payment/data/model/order_payment_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderPaymentModel> createOrder(int propertyId);
}
