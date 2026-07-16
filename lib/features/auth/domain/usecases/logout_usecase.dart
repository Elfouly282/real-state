import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repository;
  LogoutUsecase(this._repository);

  Future<Either<Failure, bool>> call() => _repository.logout();
}
