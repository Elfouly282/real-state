import 'package:get_it/get_it.dart';
import 'package:real_state/core/api/internet_connection_checker.dart';
import 'package:real_state/feature/profile/data/data_source/profile_remote_datesourse.dart';
import 'package:real_state/feature/profile/data/repositories/profile_repositoryImpl.dart';
import 'package:real_state/feature/profile/presentation/cubit/profile_cubit.dart';

// 1. Domain Layer Imports
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/change_password_usecase.dart';

// 2. Data Layer Imports


// 3. Core Imports (مسارات الكور الخاصة بك للـ NetworkInfo)


// 4. Presentation / Cubit Import (سننشئه في الخطوة القادمة)
// import 'presentation/controllers/profile_cubit.dart';

final sl = GetIt.instance;

void initProfileFeature() {
  // ------------------ Data Sources ------------------
  if (!sl.isRegistered<ProfileRemoteDataSource>()) {
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(),
    );
  }

  // ------------------ Repositories ------------------
  if (!sl.isRegistered<ProfileRepository>()) {
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: sl<ProfileRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(), // يأخذ النسخة المسجلة في الكور
      ),
    );
  }

  // ------------------ Use Cases ------------------
  if (!sl.isRegistered<GetProfileUseCase>()) {
    sl.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(sl<ProfileRepository>()),
    );
  }

  if (!sl.isRegistered<UpdateProfileUseCase>()) {
    sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl<ProfileRepository>()),
    );
  }

  if (!sl.isRegistered<ChangePasswordUseCase>()) {
    sl.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(sl<ProfileRepository>()),
    );
  }

  // ------------------ State Management (Cubit/Bloc) ------------------
  // سنقوم بفك التعليق عنها بعد إنشاء الـ Cubit

  if (!sl.isRegistered<ProfileCubit>()) {
    sl.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        getProfileUseCase: sl<GetProfileUseCase>(),
        updateProfileUseCase: sl<UpdateProfileUseCase>(),
        changePasswordUseCase: sl<ChangePasswordUseCase>(),
      ),
    );
  }

}