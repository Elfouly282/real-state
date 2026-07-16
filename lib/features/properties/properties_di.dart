import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/properties_remote_datasource.dart';
import 'data/repositories/properties_repository_impl.dart';
import 'domain/repositories/properties_repository.dart';
import 'domain/usecases/properties_usecases.dart';
import 'presentation/cubit/properties_cubit.dart';

void initPropertiesModule() {
  if (!getIt.isRegistered<PropertiesRemoteDatasource>())
    getIt.registerLazySingleton<PropertiesRemoteDatasource>(() => PropertiesRemoteDatasourceImpl());

  if (!getIt.isRegistered<PropertiesRepository>())
    getIt.registerLazySingleton<PropertiesRepository>(
        () => PropertiesRepositoryImpl(remote: getIt(), network: getIt<NetworkInfo>()));

  if (!getIt.isRegistered<GetPropertiesUsecase>())
    getIt.registerLazySingleton(() => GetPropertiesUsecase(getIt()));
  if (!getIt.isRegistered<DeletePropertyUsecase>())
    getIt.registerLazySingleton(() => DeletePropertyUsecase(getIt()));
  if (!getIt.isRegistered<CreatePropertyUsecase>())
    getIt.registerLazySingleton(() => CreatePropertyUsecase(getIt()));
  if (!getIt.isRegistered<UpdatePropertyUsecase>())
    getIt.registerLazySingleton(() => UpdatePropertyUsecase(getIt()));

  if (!getIt.isRegistered<PropertiesCubit>())
    getIt.registerFactory(() => PropertiesCubit(getIt(), getIt()));
}
