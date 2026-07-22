import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

class AdminLoadingWidget extends StatelessWidget {
  const AdminLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
}
