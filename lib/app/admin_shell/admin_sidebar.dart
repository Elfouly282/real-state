import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/custom_logo.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_styles.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import 'admin_nav_item.dart';
import 'admin_sidebar_tile.dart';
import 'sidebar_divider.dart';

class AdminSidebar extends StatelessWidget {
  final List<AdminNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AdminSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: AppColors.surfaceBg,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Image.asset(
              'assets/png/logo2.png',
              height: 44,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  CustomLogo(width: 120, height: 44, fit: BoxFit.contain),
            ),
          ),
          const SidebarDivider(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (_, i) => AdminSidebarTile(
                item: items[i],
                isSelected: i == selectedIndex,
                onTap: () => onSelect(i),
              ),
            ),
          ),
          const SidebarDivider(),
          Material(
            color: AppColors.surfaceBg,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              leading: AppIconify.logout(
                  size: 18, color: AppColors.textSecondaryColor),
              title: Text(
                'Logout',
                style: getRegularStyle(
                    fontSize: AppFonts.bodyMedium,
                    color: AppColors.textSecondaryColor),
              ),
              onTap: () => context.read<AuthCubit>().logout(),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
