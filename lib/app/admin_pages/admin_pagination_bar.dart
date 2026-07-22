import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';

/// Previous / Next pagination bar used below admin tables.
class AdminPaginationBar extends StatelessWidget {
  final int currentPage;
  final int lastPage;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const AdminPaginationBar({
    super.key,
    required this.currentPage,
    required this.lastPage,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (lastPage <= 1) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PaginationButton(
            icon: Icons.chevron_left,
            label: 'Prev',
            onTap: currentPage > 1 ? onPrev : null,
          ),
          const SizedBox(width: 16),
          Text(
            '$currentPage / $lastPage',
            style: getMediumStyle(
              fontSize: AppFonts.bodySmall,
              color: AppColors.textSecondaryColor,
            ),
          ),
          const SizedBox(width: 16),
          _PaginationButton(
            icon: Icons.chevron_right,
            label: 'Next',
            iconOnRight: true,
            onTap: currentPage < lastPage ? onNext : null,
          ),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool iconOnRight;
  final VoidCallback? onTap;

  const _PaginationButton({
    required this.icon,
    required this.label,
    this.iconOnRight = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = enabled ? AppColors.primaryColor : AppColors.greychip;
    final textColor =
        enabled ? AppColors.primaryColor : AppColors.textLightColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primaryColor.withValues(alpha: 0.08)
              : AppColors.greychip.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!iconOnRight) ...[
              Icon(icon, size: 16, color: textColor),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: getMediumStyle(
                fontSize: AppFonts.labelSmall,
                color: textColor,
              ),
            ),
            if (iconOnRight) ...[
              const SizedBox(width: 4),
              Icon(icon, size: 16, color: textColor),
            ],
          ],
        ),
      ),
    );
  }
}
