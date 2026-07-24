import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/App_routes/app_route.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/bloc_observer/bloc_service.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:real_state/features/onboarding/presentations/views/app_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initAppModule();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider<AuthCubit>(
        create: (context) => getIt<AuthCubit>(),
        child: const MaterialApp(
          home: AppLauncher(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    ),
  );
}
