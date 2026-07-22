import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, PaginatedUsersEntity>> getUsers({int perPage = 30, int page = 1});
  Future<Either<Failure, UserEntity>> getUser(int id);
  Future<Either<Failure, bool>> blockUser(int id, {required bool block});
}
