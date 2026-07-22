import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_remote_datasource.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource _remote;
  final NetworkInfo _network;

  UsersRepositoryImpl({
    required UsersRemoteDatasource remote,
    required NetworkInfo network,
  })  : _remote = remote,
        _network = network;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() fn) async {
    if (!await _network.isConnected) {
      return Left(NoInternetFailure(message: ''));
    }
    try {
      return Right(await fn());
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedUsersEntity>> getUsers({int perPage = 30, int page = 1}) =>
      _run(() => _remote.getUsers(perPage: perPage, page: page));

  @override
  Future<Either<Failure, UserEntity>> getUser(int id) =>
      _run(() => _remote.getUser(id));

  @override
  Future<Either<Failure, bool>> blockUser(int id, {required bool block}) =>
      _run(() => _remote.blockUser(id, block: block));
}
