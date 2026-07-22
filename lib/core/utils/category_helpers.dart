import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Helper class for category-related utilities (icons, gradients, etc.)
class CategoryHelpers {
  CategoryHelpers._();

  // ── Category gradient color constants ──────────────────────────────────────
  static const _grainStart      = Color(0xFF8B4513);
  static const _grainEnd        = Color(0xFFD2691E);
  static const _restaurantStart = Color(0xFF2E8B57);
  static const _restaurantEnd   = Color(0xFF3CB371);
  static const _coffeeStart     = Color(0xFF3C261A);
  static const _coffeeEnd       = Color(0xFFC67C4E);
  static const _storeStart      = Color(0xFF4169E1);
  static const _storeEnd        = Color(0xFF6495ED);
  static const _waterStart      = Color(0xFFF0F8FF);
  static const _waterEnd        = Color(0xFFE6F3FF);
  static const _buildStart      = Color(0xFF708090);
  static const _buildEnd        = Color(0xFFB0C4DE);
  static const _handyStart      = Color(0xFF8B7355);
  static const _handyEnd        = Color(0xFFCD853F);
  static const _cafeStart       = Color(0xFF4B0082);
  static const _cafeEnd         = Color(0xFF9370DB);
  static const _scaleStart      = Color(0xFF2F4F4F);
  static const _scaleEnd        = Color(0xFF708090);
  static const _barStart        = Color(0xFFDC143C);
  static const _barEnd          = Color(0xFFFF6347);
  static const _drinkStart      = Color(0xFFFFD700);
  static const _drinkEnd        = Color(0xFFFFF8DC);

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Returns the icon for a category by ID.
  static IconData getCategoryIcon(int categoryId) {
    switch (categoryId) {
      case 27:  return Icons.grain_rounded;
      case 252: return Icons.restaurant_rounded;
      case 28:  return Icons.coffee_rounded;
      case 250: return Icons.store_rounded;
      case 25:  return Icons.water_drop_rounded;
      case 23:  return Icons.build_rounded;
      case 24:  return Icons.handyman_rounded;
      case 26:  return Icons.local_cafe_rounded;
      case 46:  return Icons.scale_rounded;
      case 32:  return Icons.sports_bar_rounded;
      case 31:  return Icons.local_drink_rounded;
      default:  return Icons.category_rounded;
    }
  }

  /// Returns the gradient for a category by ID.
  static LinearGradient getCategoryGradient(int categoryId) {
    const begin = Alignment.topLeft;
    const end   = Alignment.bottomRight;
    switch (categoryId) {
      case 27:
        return const LinearGradient(colors: [_grainStart,      _grainEnd],      begin: begin, end: end);
      case 252:
        return const LinearGradient(colors: [_restaurantStart, _restaurantEnd], begin: begin, end: end);
      case 28:
        return const LinearGradient(colors: [_coffeeStart,     _coffeeEnd],     begin: begin, end: end);
      case 250:
        return const LinearGradient(colors: [_storeStart,      _storeEnd],      begin: begin, end: end);
      case 25:
        return const LinearGradient(colors: [_waterStart,      _waterEnd],      begin: begin, end: end);
      case 23:
        return const LinearGradient(colors: [_buildStart,      _buildEnd],      begin: begin, end: end);
      case 24:
        return const LinearGradient(colors: [_handyStart,      _handyEnd],      begin: begin, end: end);
      case 26:
        return const LinearGradient(colors: [_cafeStart,       _cafeEnd],       begin: begin, end: end);
      case 46:
        return const LinearGradient(colors: [_scaleStart,      _scaleEnd],      begin: begin, end: end);
      case 32:
        return const LinearGradient(colors: [_barStart,        _barEnd],        begin: begin, end: end);
      case 31:
        return const LinearGradient(colors: [_drinkStart,      _drinkEnd],      begin: begin, end: end);
      default:
        return AppColors.primaryGradient;
    }
  }
}
