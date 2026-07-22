import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';

class AdminErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const AdminErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(message,
              style: getRegularStyle(fontSize: AppFonts.bodyMedium, color: AppColors.errorColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            label: Text('Retry',
                style: getMediumStyle(fontSize: AppFonts.bodyMedium, color: AppColors.primaryColor)),
          ),
        ]),
      ),
    );
  }
}
