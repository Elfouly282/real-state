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
          // القسم الأول: Account Setting
          const SectionHeaderWidget(title: 'Account Setting'),
          MenuItemWidget(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {
              final state = context.read<ProfileCubit>().state;
              if (state is ProfileSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context
                          .read<
                            ProfileCubit
                          >(), // نمرر نفس الـ Cubit للشاشة التالية
                      child: UpdateProfilePage(currentProfile: state.profile),
                    ),
                  ),
                );
              }
            },
          ),
          MenuItemWidget(
            icon: Icons.account_circle_outlined,
            title: 'My Account',
            onTap: () {},
          ),
          const Divider(height: 32),

          // القسم الثاني: Payment
          const SectionHeaderWidget(title: 'Payment'),
          MenuItemWidget(
            icon: Icons.credit_card_outlined,
            title: 'Payment Method',
            onTap: () {},
          ),
          const Divider(height: 32),

          // القسم الثالث: Setting & Security
          const SectionHeaderWidget(title: 'Setting & Security'),
          MenuItemWidget(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        // استخدام BlocProvider.value لضمان وصول الشاشة لنفس نسخة الـ ProfileCubit
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
