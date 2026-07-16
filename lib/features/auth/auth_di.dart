import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import '../../core/security/security_helper.dart';
import 'data/datasource/auth_remote_datasource.dart';
import 'data/repository/auth_repository_impl.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'presentation/cubit/auth_cubit.dart';

void initAuthModule() {
  if (!getIt.isRegistered<AuthRemoteDatasource>()) {
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    );
  }

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remote: getIt<AuthRemoteDatasource>(),
        networkInfo: getIt<NetworkInfo>(),
        authStorage: getIt<AuthStorage>(),
      ),
    );
  }

  if (!getIt.isRegistered<LoginUsecase>()) {
    getIt.registerLazySingleton(
        () => LoginUsecase(getIt<AuthRepository>()));
  }

  if (!getIt.isRegistered<LogoutUsecase>()) {
    getIt.registerLazySingleton(
        () => LogoutUsecase(getIt<AuthRepository>()));
  }

  if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerFactory(
      () => AuthCubit(
        loginUsecase: getIt<LoginUsecase>(),
        logoutUsecase: getIt<LogoutUsecase>(),
      ),
    );
  }
}
