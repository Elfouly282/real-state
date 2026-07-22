import 'package:flutter/material.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/funcations/app_functions.dart';
import 'package:real_state/core/save%20data/save_data.dart';
import 'package:real_state/core/security/security_helper.dart';
import 'package:real_state/features/auth/presentation/views/login_screen.dart';
import 'package:real_state/features/home/prsentations/views/home_screen.dart';
import 'package:real_state/features/main_page/presentations/views/main_page_screen.dart';
import 'package:real_state/features/onboarding/presentations/views/on_boarding_screen.dart';

class AppLauncher extends StatefulWidget {
  const AppLauncher({super.key});

  @override
  State<AppLauncher> createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAppState();
    });
  }

  Future<void> checkAppState() async {
    final isOnBoardingDone =
        CacheHelper().getDataBool(key: 'OnBoarding') ?? false;
    final token = getIt<AuthStorage>().token;

    if (!isOnBoardingDone) {
      AppFunctions.navigateToAndFinish(context, OnBoardingScreen());
    } else if (token == null) {
      AppFunctions.navigateTo(context, LoginScreen());
    } else {
      AppFunctions.navigateToAndFinish(context, MainPageScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
