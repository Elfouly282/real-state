import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';

class PropertySummaryCard extends StatelessWidget {
  final PropertySummaryEntity propertySummary;

  const PropertySummaryCard({super.key, required this.propertySummary});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          height: 90.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.network(
              propertySummary.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
                child: Icon(Icons.home, size: 40.r, color: Colors.grey),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                propertySummary.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                propertySummary.address,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.star_border, size: 20.r, color: AppColors.black),
                  SizedBox(width: 4.w),
                  Text(
                    '${propertySummary.rate} Rating ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    '(${propertySummary.reviews} Reviews)',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
