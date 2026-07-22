import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/dashboard_remote_datasource.dart';
import 'data/repositories/dashboard_repository_impl.dart';
import 'domain/repositories/dashboard_repository.dart';
import 'domain/usecases/get_dashboard_usecase.dart';
import 'presentation/cubit/dashboard_cubit.dart';

void initDashboardModule() {
  if (!getIt.isRegistered<DashboardRemoteDatasource>()) {
    getIt.registerLazySingleton<DashboardRemoteDatasource>(
        () => DashboardRemoteDatasourceImpl());
  }
  if (!getIt.isRegistered<DashboardRepository>()) {
    getIt.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImpl(
            remote: getIt(), network: getIt<NetworkInfo>()));
  }
  if (!getIt.isRegistered<GetDashboardUsecase>()) {
    getIt.registerLazySingleton(() => GetDashboardUsecase(getIt()));
  }
  if (!getIt.isRegistered<DashboardCubit>()) {
    getIt.registerFactory(() => DashboardCubit(getIt()));
  }
}
