import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_styles.dart';
import 'admin_nav_item.dart';

class AdminSidebarTile extends StatelessWidget {
  final AdminNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const AdminSidebarTile(
      {super.key, required this.item, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1)
              : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                    : AppColors.primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AppIconify(
                  svg: item.svgIcon,
                  size: 17,
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.grey2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: isSelected
                    ? getMediumStyle(
                        fontSize: AppFonts.bodyMedium,
                        color: AppColors.primaryColor)
                    : getRegularStyle(
                        fontSize: AppFonts.bodyMedium,
                        color: AppColors.textSecondaryColor),
              ),
            ),
            if (isSelected)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
