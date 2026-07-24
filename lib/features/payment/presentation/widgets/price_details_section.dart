import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';

class PriceDetailsSection extends StatelessWidget {
  final String housePrice;
  final String serviceFee;
  final String totalPrice;

  const PriceDetailsSection({
    super.key,
    required this.housePrice,
    required this.serviceFee,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.priceDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 20.h),
        PriceRowItem(
          label: AppConstants.housePrices,
          value: '\$$housePrice',
        ),
        SizedBox(height: 12.h),
        PriceRowItem(
          label: AppConstants.habiSpaceServiceFee,
          value: '\$$serviceFee',
        ),
        Divider(height: 32.h),
        PriceRowItem(
          label: AppConstants.total,
          value: '\$$totalPrice',
          isBold: true,
        ),
      ],
    );
  }
}

class PriceRowItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const PriceRowItem({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18.sp : 15.sp,
            color: isBold ? AppColors.black : Colors.grey.shade800,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18.sp : 15.sp,
            color: isBold ? AppColors.black : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
