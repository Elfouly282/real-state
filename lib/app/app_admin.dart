import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/di.dart';
import '../core/utils/app_colors.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/pages/login_page.dart';

class AppAdmin extends StatelessWidget {
  const AppAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Real State Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
            fontFamily: 'Quest',
            scaffoldBackgroundColor: const Color(0xFFF5F6FA),
            dataTableTheme: const DataTableThemeData(
              headingRowHeight: 44,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 60,
              dividerThickness: 1,
            ),
          ),
          home: BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        );
      },
    );
  }
}
