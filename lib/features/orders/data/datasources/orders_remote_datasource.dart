import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDatasource {
  Future<PaginatedOrdersModel> getOrders({
    int perPage = 30,
    int page = 1,
    String? status,
  });
  Future<OrderModel> getOrder(int id);
}

class OrdersRemoteDatasourceImpl implements OrdersRemoteDatasource {
  @override
  Future<PaginatedOrdersModel> getOrders({
    int perPage = 30,
    int page = 1,
    String? status,
  }) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listOrders,
        query: {
          'per_page': perPage,
          'page': page,
          if (status != null) 'status': status,
        },
        withAuth: true,
      );
      return PaginatedOrdersModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<OrderModel> getOrder(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getOrder(id),
        withAuth: true,
      );
      return OrderModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
