import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/utils/app_colors.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentStep;
  final VoidCallback? onBackPressed;

  const BookingAppBar({
    super.key,
    required this.currentStep,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        color: AppColors.offWhiteBg,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 230, 158, 12),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                    onPressed:
                        onBackPressed ?? () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Text(
                      currentStep,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
