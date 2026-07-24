import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class InsuranceSection extends StatelessWidget {
  const InsuranceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.insurancee,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConstants.chooseInsurance,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15.sp,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade800,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 90.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const InsuranceCard(
                icon: Icons.home_outlined,
                title: AppConstants.bargainHome,
                price: AppConstants.bargainHomePrice,
              ),
              SizedBox(width: 14.w),
              const InsuranceCard(
                icon: Icons.local_parking_outlined,
                title: AppConstants.smartHome,
                price: AppConstants.smartHomePrice,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InsuranceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String price;

  const InsuranceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.offWhiteBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.paymentTeal,
            size: 28.r,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
