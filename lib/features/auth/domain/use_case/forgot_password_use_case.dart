import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({required String email}) async {
    return await repository.forgotPassword(email: email);
  }
}
