import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/security/security_helper.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthStorage authStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.authStorage,
  });

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await authStorage.setToken(response.token);

      return Right(response);
    } on ServerException catch (error) {
      return left(ServiceFailure(message: error.message));
    } catch (error) {
      return left(ServiceFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      // Save auth data
      await authStorage.setToken(response.token);
      if (response.user.id != null) {
        await authStorage.setUserId(response.user.id!);
      }

      return Right(response);
    } on ServerException catch (error) {
      return left(ServiceFailure(message: error.message));
    } catch (error) {
      return left(ServiceFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final message = await remoteDataSource.forgotPassword(email: email);
      return Right(message);
    } on ServerException catch (error) {
      return left(ServiceFailure(message: error.message));
    } catch (error) {
      return left(ServiceFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final message = await remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        password: password,
        confirmPassword: confirmPassword,
      );
      return Right(message);
    } on ServerException catch (error) {
      return left(ServiceFailure(message: error.message));
    } catch (error) {
      return left(ServiceFailure(message: error.toString()));
    }
  }
}
