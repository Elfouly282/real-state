import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/failure.dart';
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

      // Response is an array → first element → "data" key
      final raw = res.data;
      final Map<String, dynamic> json;

      if (raw is List && raw.isNotEmpty) {
        json = raw[0] as Map<String, dynamic>;
      } else if (raw is Map<String, dynamic>) {
        json = raw;
      } else {
        throw ServerException('Unexpected dashboard response format');
      }

      return DashboardModel.fromJson(json);
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  String _msg(DioException e) {
    final d = e.response?.data;
    if (d is List && d.isNotEmpty) return (d[0] as Map)['message'] ?? e.message ?? '';
    if (d is Map) return d['message'] ?? e.message ?? '';
    return e.message ?? 'Unknown error';
  }
}
