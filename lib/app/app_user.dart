import 'package:flutter/material.dart';
import 'package:real_state/feature/favorite/presentation/view/favorite_view.dart';
// import 'package:real_state/feature/profile/presentation/view/profile_view.dart';

class AppUser extends StatelessWidget {
  const AppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FavoriteView(),
    );
  }
}
