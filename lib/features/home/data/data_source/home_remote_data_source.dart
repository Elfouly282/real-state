import 'package:dio/dio.dart';
import 'package:real_state/core/api/constant_API.dart';
import 'package:real_state/core/errors/failure.dart';

import '../models/home_response_model.dart';

import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/features/home/data/data_source/home_remote_data_source.dart';
import 'package:real_state/features/home/data/models/home_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeResponseModel> getHomeData({int? categoryID, String? search});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeResponseModel> getHomeData({
    int? categoryID,
    String? search,
  }) async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.home,
        query: categoryID == null && search == null
            ? null
            : {'category_id': categoryID, 'search': search},
      );
      return HomeResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response!.data['message'] ?? "Something went wrong",
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
