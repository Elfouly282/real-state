import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_styles.dart';
import '../../features/auth/domain/entities/auth_entity.dart';
import '../admin_pages/admin_profile_page.dart';

class AdminTopBar extends StatelessWidget {
  final String title;
  final bool showMenu;
  final VoidCallback onMenu;
  final String svgIcon;
  final AuthEntity? admin;

  const AdminTopBar({
    super.key,
    required this.title,
    required this.showMenu,
    required this.onMenu,
    required this.svgIcon,
    this.admin,
  });

  @override
  Widget build(BuildContext context) {
    final initial = admin?.name.isNotEmpty == true
        ? admin!.name[0].toUpperCase()
        : 'A';

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
            bottom: BorderSide(color: AppColors.greychip, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showMenu) ...[
            IconButton(
              icon: const Icon(AppIcons.menu,
                  color: AppColors.secondaryColor, size: 22),
              onPressed: onMenu,
            ),
            const SizedBox(width: 4),
          ],
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: AppIconify(
                  svg: svgIcon, size: 18, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: getBoldStyle(
                fontSize: AppFonts.titleMedium,
                color: AppColors.secondaryColor),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: AppIconify.notification(
                    size: 22, color: AppColors.secondaryColor),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: AppColors.errorColor, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (admin != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AdminProfilePage(admin: admin!),
                  ),
                );
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  initial,
                  style: getBoldStyle(
                      fontSize: AppFonts.bodyMedium, color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
