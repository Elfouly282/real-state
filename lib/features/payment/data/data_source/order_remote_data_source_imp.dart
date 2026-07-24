import 'package:real_state/features/payment/data/data_source/order_remote_data_source.dart';
import 'package:real_state/features/payment/data/model/order_payment_model.dart';

import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/remote_exception.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<OrderPaymentModel> createOrder(int propertyId) async {
    try {
      var response = await DioHelper.postData(
        url: EndPoints.orders,
        data: {'property_id': propertyId},
        withAuth: true,
      );

      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! >= 300) {
        throw RemoteException(
          '${response.statusCode}, ${response.statusMessage}',
        );
      }

      return OrderPaymentModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      if (e is RemoteException) rethrow;
      throw RemoteException(e.toString());
    }
  }
}
