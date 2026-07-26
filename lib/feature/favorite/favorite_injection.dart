import 'package:get_it/get_it.dart';
import 'package:real_state/core/api/internet_connection_checker.dart';
import 'package:real_state/feature/favorite/data/data_source/favorites_remote_data_source.dart';
import 'package:real_state/feature/favorite/data/repositories/favorites_repository_impl.dart';
import 'package:real_state/feature/favorite/domain/repositories/favorites_repository.dart';
import 'package:real_state/feature/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:real_state/feature/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:real_state/feature/favorite/presentation/cubit/favorite_cubit.dart';
// استورد الملفات الخاصة بالفيتشر هنا (DataSources, Repositories, UseCases, Cubit)

final sl = GetIt.instance;

void initFavoriteFeature() {
  // ------------------ Data Sources ------------------
  if (!sl.isRegistered<FavoritesRemoteDataSource>()) {
    sl.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(),
    );
  }

  // ------------------ Repositories ------------------
  if (!sl.isRegistered<FavoritesRepository>()) {
    sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        remoteDataSource: sl<FavoritesRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );
  }

  // ------------------ Use Cases ------------------
  if (!sl.isRegistered<GetFavoritesUseCase>()) {
    sl.registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(sl<FavoritesRepository>()),
    );
  }

  if (!sl.isRegistered<ToggleFavoriteUseCase>()) {
    sl.registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(sl<FavoritesRepository>()),
    );
  }

  // ------------------ State Management (Cubit/Bloc) ------------------
  if (!sl.isRegistered<FavoriteCubit>()) {
    sl.registerFactory<FavoriteCubit>(
      () => FavoriteCubit(
        getFavoritesUseCase: sl<GetFavoritesUseCase>(),
        toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
      ),
    );
  }
}