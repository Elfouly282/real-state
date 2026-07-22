import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    return await repository.resetPassword(
      email: email,
      otp: otp,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
