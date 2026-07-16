import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/orders_remote_datasource.dart';
import 'data/repositories/orders_repository_impl.dart';
import 'domain/repositories/orders_repository.dart';
import 'domain/usecases/orders_usecases.dart';
import 'presentation/cubit/orders_cubit.dart';

void initOrdersModule() {
  if (!getIt.isRegistered<OrdersRemoteDatasource>())
    getIt.registerLazySingleton<OrdersRemoteDatasource>(() => OrdersRemoteDatasourceImpl());

  if (!getIt.isRegistered<OrdersRepository>())
    getIt.registerLazySingleton<OrdersRepository>(
        () => OrdersRepositoryImpl(remote: getIt(), network: getIt<NetworkInfo>()));

  if (!getIt.isRegistered<GetOrdersUsecase>())
    getIt.registerLazySingleton(() => GetOrdersUsecase(getIt()));

  if (!getIt.isRegistered<OrdersCubit>())
    getIt.registerFactory(() => OrdersCubit(getIt()));
}
