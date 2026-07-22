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
      try {
        await _authStorage.clearAuth();
      } catch (_) {
        // ignore storage errors when offline
      }
      return const Right(true);
    }

    // Call API first while token is still in memory.
    try {
      await _remote.logout();
    } on ServerException catch (_) {
      // Remote logout failed — still clear local credentials below.
    } catch (_) {
      // Unexpected error — still clear local credentials below.
    }

    // Always clear local credentials after the API call attempt.
    try {
      await _authStorage.clearAuth();
    } catch (_) {
      // ignore storage errors
    }

    return const Right(true);
  }
}
