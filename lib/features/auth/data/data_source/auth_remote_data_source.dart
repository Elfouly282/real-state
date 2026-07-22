import 'package:dio/dio.dart';
import 'package:real_state/core/errors/failure.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../model/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<String> forgotPassword({required String email});

  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: {'email': email, 'password': password},
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response!.data['message'] ?? 'Something went wrong',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response!.data['message'] ?? 'Something went wrong',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.forgotPassword,
        data: {'email': email},
      );
      return response.data['message'] ?? 'Verification code sent to your email';
    } on DioException catch (e) {
      throw ServerException(
        e.response!.data['message'] ?? 'Something went wrong',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.resetPassword,
        data: {
          'email': email,
          'otp': otp,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );
      return response.data['message'] ?? 'Password reset successfully';
    } on DioException catch (e) {
      throw ServerException(
        e.response!.data['message'] ?? 'Something went wrong',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
