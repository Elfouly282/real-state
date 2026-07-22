import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';

class AdminEmptyView extends StatelessWidget {
  final String message;
  const AdminEmptyView(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(message,
            style: getRegularStyle(
                fontSize: AppFonts.bodyMedium, color: AppColors.textSecondaryColor)),
      );
}
