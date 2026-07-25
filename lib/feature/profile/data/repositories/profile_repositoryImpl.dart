import 'package:dartz/dartz.dart';
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

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getProfile();
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(ServiceFailure(message: e.message));
      } catch (e) {
        return Left(ServiceFailure(message:e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message:'لا يوجد اتصال بالإنترنت'));
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
        return Left(ServiceFailure(message:e.message));
      } catch (e) {
        return Left(ServiceFailure(message:e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message:'لا يوجد اتصال بالإنترنت'));
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
        return Left(ServiceFailure(message:e.message));
      } catch (e) {
        return Left(ServiceFailure(message:e.toString()));
      }
    } else {
      return Left(NoInternetFailure(message:'لا يوجد اتصال بالإنترنت'));
    }
  }
}