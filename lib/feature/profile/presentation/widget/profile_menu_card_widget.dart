import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:real_state/feature/profile/presentation/view/change_password_view.dart';
import 'package:real_state/feature/profile/presentation/view/update_profile_page.dart';
import 'package:real_state/feature/profile/presentation/widget/menu_item_widget.dart';
import 'package:real_state/feature/profile/presentation/widget/section_header_widget.dart';

class ProfileMenuCardWidget extends StatelessWidget {
  const ProfileMenuCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderWidget(title: 'Account Setting'),
          MenuItemWidget(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {
              final cubit = context.read<ProfileCubit>();
              final profile =
                  cubit.currentProfile ??
                  (cubit.state is ProfileSuccess
                      ? (cubit.state as ProfileSuccess).profile
                      : null);

              if (profile != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: UpdateProfilePage(currentProfile: profile),
                    ),
                  ),
                );
              } else {
                cubit.getProfile();
              }
            },
          ),
          MenuItemWidget(
            icon: Icons.account_circle_outlined,
            title: 'My Account',
            onTap: () {},
          ),
          const Divider(height: 32),

          // Section 2: Payment
          const SectionHeaderWidget(title: 'Payment'),
          MenuItemWidget(
            icon: Icons.credit_card_outlined,
            title: 'Payment Method',
            onTap: () {},
          ),
          const Divider(height: 32),

          const SectionHeaderWidget(title: 'Setting & Security'),
          MenuItemWidget(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: const ChangePasswordView(),
                  ),
                ),
              );
            },
          ),
          MenuItemWidget(
            icon: Icons.notifications_none_outlined,
            title: 'Notification Preference',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
