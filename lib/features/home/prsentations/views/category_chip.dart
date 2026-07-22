import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/utils/app_colors.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: InkWell(
        onTap: onTap,

        child: Container(
          height: 36.h,
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff1597A8) : Color(0xffBFF8FF),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : const Color(0xff1597A8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
