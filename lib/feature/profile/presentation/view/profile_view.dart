import 'package:flutter/material.dart';
import 'package:real_state/feature/profile/presentation/widget/profile_view_content.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: ProfileViewContent(),
    );
  }
}