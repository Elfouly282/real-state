import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthResponse>> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
