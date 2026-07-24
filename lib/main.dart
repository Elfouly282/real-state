// ──────────────────────────────────────────────────────────────────────────────
// Entry points:
//
//  User App  (mobile):
//    flutter run -t lib/main_user.dart --flavor user
//
//  Admin Dashboard (web):
//    flutter run -t lib/main_admin.dart --flavor admin -d chrome
//
// Run flavorizr to generate platform configs:
//    dart run flutter_flavorizr
// ──────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/features/onboarding/presentations/views/app_launcher.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: const MaterialApp(
        home: AppLauncher(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
