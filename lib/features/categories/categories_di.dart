import '../../core/api/internet_connection_checker.dart';
import '../../core/di.dart' show getIt;
import 'data/datasources/categories_remote_datasource.dart';
import 'data/repositories/categories_repository_impl.dart';
import 'domain/repositories/categories_repository.dart';
import 'domain/usecases/get_categories_usecase.dart';
import 'presentation/cubit/categories_cubit.dart';

void initCategoriesModule() {
  if (!getIt.isRegistered<CategoriesRemoteDatasource>())
    getIt.registerLazySingleton<CategoriesRemoteDatasource>(() => CategoriesRemoteDatasourceImpl());

  if (!getIt.isRegistered<CategoriesRepository>())
    getIt.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImpl(remote: getIt(), network: getIt<NetworkInfo>()));

  if (!getIt.isRegistered<GetCategoriesUsecase>())
    getIt.registerLazySingleton(() => GetCategoriesUsecase(getIt()));
  if (!getIt.isRegistered<CreateCategoryUsecase>())
    getIt.registerLazySingleton(() => CreateCategoryUsecase(getIt()));
  if (!getIt.isRegistered<UpdateCategoryUsecase>())
    getIt.registerLazySingleton(() => UpdateCategoryUsecase(getIt()));
  if (!getIt.isRegistered<DeleteCategoryUsecase>())
    getIt.registerLazySingleton(() => DeleteCategoryUsecase(getIt()));

  if (!getIt.isRegistered<CategoriesCubit>())
    getIt.registerFactory(() => CategoriesCubit(getIt(), getIt(), getIt(), getIt()));
}
