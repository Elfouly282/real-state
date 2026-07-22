import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const FieldLabel({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: getMediumStyle(
              fontSize: AppFonts.labelLarge,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
