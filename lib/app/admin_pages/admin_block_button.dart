import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

class AdminBlockButton extends StatelessWidget {
  final bool isBlocked;
  final VoidCallback onTap;

  const AdminBlockButton({
    super.key,
    required this.isBlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isBlocked ? AppColors.successColor : AppColors.errorColor;
    final icon  = isBlocked ? Icons.lock_open_outlined : Icons.block_outlined;

    return Tooltip(
      message: isBlocked ? 'Unblock User' : 'Block User',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
