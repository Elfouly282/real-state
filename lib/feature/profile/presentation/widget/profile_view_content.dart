import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:real_state/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:real_state/feature/profile/presentation/widget/profile_header_widget.dart';
import 'package:real_state/feature/profile/presentation/widget/profile_menu_card_widget.dart';
import 'package:real_state/feature/profile/profile_injector.dart';

class ProfileViewContent extends StatelessWidget {
  const ProfileViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getProfile(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ProfileHeaderWidget(),
              SizedBox(height: 16),
              ProfileMenuCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
