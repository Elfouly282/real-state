import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';
import 'package:real_state/feature/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String name,
    required String email,
    required String location, 
    required String phone,    
  }) async {
    return await repository.updateProfile(
      name: name,
      email: email,
      location: location,
      phone: phone,
    );
  }
}