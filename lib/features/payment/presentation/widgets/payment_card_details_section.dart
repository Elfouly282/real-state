import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class PaymentCardDetailsSection extends StatelessWidget {
  const PaymentCardDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.paymentDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          AppConstants.paymentDetailsSubtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14.sp,
            height: 1.35,
          ),
        ),
        Divider(height: 32.h),
        Text(
          AppConstants.cardNumber,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        const CardNumberInputField(
          initialValue: AppConstants.dummyCardNumber,
        ),
      ],
    );
  }
}

class CardNumberInputField extends StatelessWidget {
  final String initialValue;

  const CardNumberInputField({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.offWhiteBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              initialValue,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const VisaBadgeWidget(),
        ],
      ),
    );
  }
}

class VisaBadgeWidget extends StatelessWidget {
  const VisaBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppConstants.visaText,
      style: TextStyle(
        color: AppColors.visaBlue,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        fontSize: 22.sp,
        letterSpacing: 1.2,
      ),
    );
  }
}
