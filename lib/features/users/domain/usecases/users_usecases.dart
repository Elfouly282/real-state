import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/users_repository.dart';

class GetUsersUsecase {
  final UsersRepository _repo;
  GetUsersUsecase(this._repo);
  Future<Either<Failure, List<UserEntity>>> call() => _repo.getUsers();
}

class GetUserUsecase {
  final UsersRepository _repo;
  GetUserUsecase(this._repo);
  Future<Either<Failure, UserEntity>> call(int id) => _repo.getUser(id);
}

class BlockUserUsecase {
  final UsersRepository _repo;
  BlockUserUsecase(this._repo);
  Future<Either<Failure, bool>> call(int id) => _repo.blockUser(id);
}
