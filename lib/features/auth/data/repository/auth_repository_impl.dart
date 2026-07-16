import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/security/security_helper.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;
  final NetworkInfo _networkInfo;
  final AuthStorage _authStorage;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remote,
    required NetworkInfo networkInfo,
    required AuthStorage authStorage,
  })  : _remote = remote,
        _networkInfo = networkInfo,
        _authStorage = authStorage;

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return Left(NoInternetFailure(message: 'لا يوجد اتصال بالإنترنت'));
    }
    try {
      final model = await _remote.login(email: email, password: password);

      // Persist token & userId securely using existing AuthStorage
      await _authStorage.setToken(model.token);
      await _authStorage.setUserId(model.id.toString());

      return Right(model);
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (!await _networkInfo.isConnected) {
      return Left(NoInternetFailure(message: 'لا يوجد اتصال بالإنترنت'));
    }
    try {
      await _remote.logout();
      await _authStorage.clearAuth();
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }
}
