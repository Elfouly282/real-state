import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {

  Future<Either<Failure, ProfileEntity>> getProfile();

  
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
    required String location,
    required String phone,
  });

 
  Future<Either<Failure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}