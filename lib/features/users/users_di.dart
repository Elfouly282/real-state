import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/users_remote_datasource.dart';
import 'data/repositories/users_repository_impl.dart';
import 'domain/repositories/users_repository.dart';
import 'domain/usecases/users_usecases.dart';
import 'presentation/cubit/users_cubit.dart';

void initUsersModule() {
  if (!getIt.isRegistered<UsersRemoteDatasource>())
    getIt.registerLazySingleton<UsersRemoteDatasource>(() => UsersRemoteDatasourceImpl());

  if (!getIt.isRegistered<UsersRepository>())
    getIt.registerLazySingleton<UsersRepository>(
        () => UsersRepositoryImpl(remote: getIt(), network: getIt<NetworkInfo>()));

  if (!getIt.isRegistered<GetUsersUsecase>())
    getIt.registerLazySingleton(() => GetUsersUsecase(getIt()));
  if (!getIt.isRegistered<BlockUserUsecase>())
    getIt.registerLazySingleton(() => BlockUserUsecase(getIt()));

  if (!getIt.isRegistered<UsersCubit>())
    getIt.registerFactory(() => UsersCubit(getIt(), getIt()));
}
