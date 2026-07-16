import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/auth_entity.dart';
import '../repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;
  LoginUsecase(this._repository);

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
}
