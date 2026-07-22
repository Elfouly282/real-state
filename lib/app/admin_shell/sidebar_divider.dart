import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

class SidebarDivider extends StatelessWidget {
  const SidebarDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.greychip,
    );
  }
}
