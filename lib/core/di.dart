import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:real_state/features/home/data/data_source/home_remote_data_source.dart';
import 'package:real_state/features/home/data/repository/home_repository_impl.dart';
import 'package:real_state/features/home/domain/repository/home_repository.dart';
import 'package:real_state/features/home/domain/use_case/get_home_data_use_case.dart';
import 'package:real_state/features/home/prsentations/cubit/home_cubit.dart';
import 'package:real_state/features/main_page/presentations/cubit/main_page_cubit.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';

// Auth feature Clean Architecture imports
import '../features/auth/data/data_source/auth_remote_data_source.dart';
import '../features/auth/data/repositroy/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/use_case/login_use_case.dart';
import '../features/auth/domain/use_case/register_use_case.dart';
import '../features/auth/domain/use_case/forgot_password_use_case.dart';
import '../features/auth/domain/use_case/reset_password_use_case.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> initAppModule() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);

  final securityHelper = SecurityHelper();
  getIt.registerLazySingleton<SecurityHelper>(() => securityHelper);

  final authStorage = AuthStorage(getIt<SecurityHelper>());
  await authStorage.migrateFromCacheIfNeeded(cacheHelper);
  await authStorage.loadFromSecure();
  getIt.registerLazySingleton<AuthStorage>(() => authStorage);

  await DioHelper.init();
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  // ==========================================
  // Auth Feature Clean Architecture Setup
  // ==========================================

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
      authStorage: getIt<AuthStorage>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory(() => MainPageCubit());
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );

  getIt.registerLazySingleton(
    () => GetHomeDataUseCase(getIt<HomeRepository>()),
  );

  getIt.registerFactory(() => HomeCubit(getIt<GetHomeDataUseCase>()));
  // Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    ),
  );
}
