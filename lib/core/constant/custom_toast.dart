import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/app_fonts.dart';
import '../utils/app_colors.dart';

class CustomToast {
  static void showSuccess(
    String message, {
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: AppColors.successColor,
      textColor: Colors.white,
      fontSize: AppFonts.bodyMedium,
    );
  }

  static void showError(
    String message, {
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: AppColors.errorColor,
      textColor: Colors.white,
      fontSize: AppFonts.bodyMedium,
    );
  }

  static void showInfo(
    String message, {
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: AppColors.infoColor,
      textColor: Colors.white,
      fontSize: AppFonts.bodyMedium,
    );
  }

  static void showWarning(
    String message, {
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: AppColors.warningColor,
      textColor: Colors.black87,
      fontSize: AppFonts.bodyMedium,
    );
  }

  static void showCustom(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      textColor: textColor ?? Colors.white,
      fontSize: AppFonts.bodyMedium,
    );
  }
}
