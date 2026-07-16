import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class UsersRemoteDatasource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUser(int id);
  Future<bool> blockUser(int id);
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final res = await DioHelper.getData(url: EndPoints.listUsers, withAuth: true);
      final list = _extractList(res.data);
      return list.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<UserModel> getUser(int id) async {
    try {
      final res = await DioHelper.getData(url: EndPoints.getUser(id), withAuth: true);
      return UserModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<bool> blockUser(int id) async {
    try {
      await DioHelper.patchData(url: EndPoints.blockUser(id), withAuth: true);
      return true;
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  List _extractList(dynamic raw) {
    if (raw is List) return raw;
    if (raw is Map && raw['data'] is List) return raw['data'] as List;
    return [];
  }

  Map<String, dynamic> _extractData(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0] as Map;
      return (first['data'] ?? first) as Map<String, dynamic>;
    }
    if (raw is Map) return (raw['data'] ?? raw) as Map<String, dynamic>;
    return {};
  }

  String _msg(DioException e) {
    final d = e.response?.data;
    if (d is Map) return d['message'] ?? e.message ?? '';
    return e.message ?? 'Unknown error';
  }
}
