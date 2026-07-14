import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.check, this.onTap});
  final bool check;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25.w,
        height: 25.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor),
          color: check ? AppColors.primaryColor : Colors.transparent,
        ),
        child: check
            ? Icon(Icons.check, color: Colors.white, size: 14.sp)
            : null,
      ),
    );
  }
}
