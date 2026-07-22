import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/dashboard_model.dart';

abstract class DashboardRemoteDatasource {
  Future<DashboardModel> getDashboard();
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  @override
  Future<DashboardModel> getDashboard() async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.dashboard,
        withAuth: true,
      );
      final raw = res.data;
      final Map<String, dynamic> json;

      if (raw is List && raw.isNotEmpty) {
        json = raw[0] as Map<String, dynamic>;
      } else if (raw is Map<String, dynamic>) {
        json = raw;
      } else {
        throw const ServerException('Unexpected dashboard response format');
      }

      return DashboardModel.fromJson(json);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
