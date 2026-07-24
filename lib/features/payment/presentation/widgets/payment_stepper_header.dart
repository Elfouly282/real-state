import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class PaymentStepperHeader extends StatelessWidget {
  final int currentStep;

  const PaymentStepperHeader({super.key, this.currentStep = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        scrollDirection: Axis.horizontal,
        children: [
          PaymentStepItem(
            stepNumber: 1,
            title: AppConstants.reviewData,
            isActive: currentStep >= 1,
          ),
          SizedBox(width: 16.w),
          PaymentStepItem(
            stepNumber: 2,
            title: AppConstants.paymentDetails,
            isActive: currentStep >= 2,
          ),
          SizedBox(width: 16.w),
          PaymentStepItem(
            stepNumber: 3,
            title: AppConstants.done,
            isActive: currentStep >= 3,
          ),
        ],
      ),
    );
  }
}

class PaymentStepItem extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isActive;

  const PaymentStepItem({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26.w,
          height: 26.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.paymentTeal : Colors.transparent,
            border: Border.all(
              color: isActive ? AppColors.paymentTeal : Colors.grey.shade700,
              width: 1.5.w,
            ),
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: isActive ? AppColors.white : Colors.grey.shade800,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? AppColors.paymentTeal : Colors.grey.shade900,
          ),
        ),
      ],
    );
  }
}
