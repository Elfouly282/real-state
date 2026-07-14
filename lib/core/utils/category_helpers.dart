import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Helper class for category-related utilities (icons, gradients, etc.)
class CategoryHelpers {
  /// Get icon data for a category by ID
  static IconData getCategoryIcon(int categoryId) {
    switch (categoryId) {
      case 27:
        return Icons.grain_rounded;
      case 252:
        return Icons.restaurant_rounded;
      case 28:
        return Icons.coffee_rounded;
      case 250:
        return Icons.store_rounded;
      case 25:
        return Icons.water_drop_rounded;
      case 23:
        return Icons.build_rounded;
      case 24:
        return Icons.handyman_rounded;
      case 26:
        return Icons.local_cafe_rounded;
      case 46:
        return Icons.scale_rounded;
      case 32:
        return Icons.sports_bar_rounded;
      case 31:
        return Icons.local_drink_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  static LinearGradient getCategoryGradient(int categoryId) {
    switch (categoryId) {
      case 27:
        return const LinearGradient(
          colors: [Color(0xFF8B4513), Color(0xFFD2691E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 252:
        return const LinearGradient(
          colors: [Color(0xFF2E8B57), Color(0xFF3CB371)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 28:
        return const LinearGradient(
          colors: [Color(0xFF3C261A), Color(0xFFC67C4E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 250:
        return const LinearGradient(
          colors: [Color(0xFF4169E1), Color(0xFF6495ED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 25:
        return const LinearGradient(
          colors: [Color(0xFFF0F8FF), Color(0xFFE6F3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 23:
        return const LinearGradient(
          colors: [Color(0xFF708090), Color(0xFFB0C4DE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 24:
        return const LinearGradient(
          colors: [Color(0xFF8B7355), Color(0xFFCD853F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 26:
        return const LinearGradient(
          colors: [Color(0xFF4B0082), Color(0xFF9370DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 46:
        return const LinearGradient(
          colors: [Color(0xFF2F4F4F), Color(0xFF708090)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 32:
        return const LinearGradient(
          colors: [Color(0xFFDC143C), Color(0xFFFF6347)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 31:
        return const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFF8DC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return AppColors.primaryGradient;
    }
  }
}
