import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/agents_remote_datasource.dart';
import 'data/repositories/agents_repository_impl.dart';
import 'domain/repositories/agents_repository.dart';
import 'domain/usecases/agents_usecases.dart';
import 'presentation/cubit/agents_cubit.dart';

void initAgentsModule() {
  if (!getIt.isRegistered<AgentsRemoteDatasource>()) {
    getIt.registerLazySingleton<AgentsRemoteDatasource>(
        () => AgentsRemoteDatasourceImpl());
  }
  if (!getIt.isRegistered<AgentsRepository>()) {
    getIt.registerLazySingleton<AgentsRepository>(
        () => AgentsRepositoryImpl(
            remote: getIt(), network: getIt<NetworkInfo>()));
  }
  if (!getIt.isRegistered<GetAgentsUsecase>()) {
    getIt.registerLazySingleton(() => GetAgentsUsecase(getIt()));
  }
  if (!getIt.isRegistered<GetAgentUsecase>()) {
    getIt.registerLazySingleton(() => GetAgentUsecase(getIt()));
  }
  if (!getIt.isRegistered<CreateAgentUsecase>()) {
    getIt.registerLazySingleton(() => CreateAgentUsecase(getIt()));
  }
  if (!getIt.isRegistered<UpdateAgentUsecase>()) {
    getIt.registerLazySingleton(() => UpdateAgentUsecase(getIt()));
  }
  if (!getIt.isRegistered<DeleteAgentUsecase>()) {
    getIt.registerLazySingleton(() => DeleteAgentUsecase(getIt()));
  }
  if (!getIt.isRegistered<AgentsCubit>()) {
    getIt.registerFactory(() => AgentsCubit(getIt(), getIt()));
  }
}
