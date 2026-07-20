import 'package:flutter/material.dart';
import 'package:real_state/core/App_routes/app_route.dart';

class AppUser extends StatelessWidget {
  const AppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
