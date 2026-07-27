import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_state/core/api/internet_connection_checker.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/profile/data/data_source/profile_remote_datesourse.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';
import 'package:real_state/feature/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  String _extractDioErrorMessage(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final data = e.response!.data as Map;
      if (data['errors'] != null && data['errors'] is Map) {
        final errors = data['errors'] as Map;
        if (errors.isNotEmpty) {
          final firstKey = errors.keys.first;
          final firstErrorList = errors[firstKey];
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            return firstErrorList.first.toString();
          }
        }
      }
      if (data.containsKey('message')) {
        return data['message'].toString();
      }
    }
    return e.message ?? 'A server connection error occurred';
  }

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getProfile();
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(ServiceFailure(message: e.message));
      } on DioException catch (e) {
        return Left(ServiceFailure(message: _extractDioErrorMessage(e)));
      } catch (e) {
        return Left(ServiceFailure(message: e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
    required String location,
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedProfile = await remoteDataSource.updateProfile(
          name: name,
          email: email,
          location: location,
          phone: phone,
        );
        return Right(updatedProfile);
      } on ServerException catch (e) {
        return Left(ServiceFailure(message: e.message));
      } on DioException catch (e) {
        return Left(ServiceFailure(message: _extractDioErrorMessage(e)));
      } catch (e) {
        return Left(ServiceFailure(message: e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServiceFailure(message: e.message));
      } on DioException catch (e) {
        return Left(ServiceFailure(message: _extractDioErrorMessage(e)));
      } catch (e) {
        return Left(ServiceFailure(message: e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message: 'No internet connection'));
    }
  }
}