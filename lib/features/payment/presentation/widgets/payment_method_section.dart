import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.paymentMethod,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 16.h),
        const PaymentMethodCard(title: AppConstants.bankTransfer),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String title;

  const PaymentMethodCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade400, width: 1.2.w),
      ),
      child: Row(
        children: [
          Icon(
            Icons.credit_card,
            color: AppColors.black,
            size: 26.r,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade800,
            size: 24.r,
          ),
        ],
      ),
    );
  }
}
