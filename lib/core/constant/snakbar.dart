import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';


class CustomSnackbar {
  final Color backgroundColor;
  final String label;
  final bool isError;

  CustomSnackbar(this.backgroundColor, this.label, this.isError);

  void show(BuildContext context) {
    IconSnackBar.show(
      context,
      snackBarType: isError ? SnackBarType.fail : SnackBarType.success,
      label: label,
      labelTextStyle: getRegularStyle(fontSize: 16.sp, color: AppColors.white),
      iconColor: AppColors.white,
      backgroundColor: backgroundColor,
      maxLines: 2,
    );
  }
}
