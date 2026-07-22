import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersRemoteDatasource {
  Future<PaginatedUsersModel> getUsers({int perPage = 30, int page = 1});
  Future<UserModel> getUser(int id);
  Future<bool> blockUser(int id, {required bool block});
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  @override
  Future<PaginatedUsersModel> getUsers({int perPage = 30, int page = 1}) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listUsers,
        query: {'per_page': perPage, 'page': page},
        withAuth: true,
      );
      return PaginatedUsersModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<UserModel> getUser(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getUser(id),
        withAuth: true,
      );
      return UserModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<bool> blockUser(int id, {required bool block}) async {
    // API confirmed: PATCH /admin/users/{id}/block with { is_blocked: bool }
    try {
      await DioHelper.patchData(
        url: EndPoints.blockUser(id),
        data: {'is_blocked': block},
        withAuth: true,
      );
      return true;
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
