import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/users_repository.dart';

class GetUsersUsecase {
  final UsersRepository _repo;
  GetUsersUsecase(this._repo);
  Future<Either<Failure, PaginatedUsersEntity>> call({int perPage = 30, int page = 1}) =>
      _repo.getUsers(perPage: perPage, page: page);
}

class GetUserUsecase {
  final UsersRepository _repo;
  GetUserUsecase(this._repo);
  Future<Either<Failure, UserEntity>> call(int id) => _repo.getUser(id);
}

class BlockUserUsecase {
  final UsersRepository _repo;
  BlockUserUsecase(this._repo);
  Future<Either<Failure, bool>> call(int id, {required bool block}) =>
      _repo.blockUser(id, block: block);
}
