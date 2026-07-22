import 'package:flutter/material.dart';
import 'app_colors.dart';

 // Returns the display colour for a property status string.
Color propertyStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'published':
      return AppColors.successColor;
    case 'sold':
      return AppColors.errorColor;
    case 'draft':
      return AppColors.warningColor;
    default:
      return AppColors.textSecondaryColor;
  }
}

 // Returns the display colour for an order status string.
Color orderStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'paid':
      return AppColors.successColor;
    case 'pending':
      return AppColors.warningColor;
    case 'cancelled':
      return AppColors.errorColor;
    default:
      return AppColors.textSecondaryColor;
  }
}
