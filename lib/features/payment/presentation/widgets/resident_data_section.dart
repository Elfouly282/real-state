import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class ResidentDataSection extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String noticeText;

  const ResidentDataSection({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.noticeText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.residentData,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          phone,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          email,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 18.h),
        ResidentNoticeBox(text: noticeText),
      ],
    );
  }
}

class ResidentNoticeBox extends StatelessWidget {
  final String text;

  const ResidentNoticeBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.lightGreenBg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.darkGreenText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          height: 1.35,
        ),
      ),
    );
  }
}
