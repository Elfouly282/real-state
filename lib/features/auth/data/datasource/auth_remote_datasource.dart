import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> login({required String email, required String password});
  Future<bool> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: {'email': email, 'password': password},
      );

      final raw = response.data;
      final Map<String, dynamic> firstItem;

      if (raw is List && raw.isNotEmpty) {
        firstItem = raw[0] as Map<String, dynamic>;
      } else if (raw is Map<String, dynamic>) {
        firstItem = raw;
      } else {
        throw const ServerException('Unexpected response format');
      }

      return AuthModel.fromJson(firstItem);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await DioHelper.postData(
        url: EndPoints.logout,
        data: {},
        withAuth: true,
      );
      return true;
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
