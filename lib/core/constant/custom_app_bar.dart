import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.back});
  final String title;
  final bool? back;

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimaryColor),
      leading: back == false
          ? SizedBox.shrink()
          : GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(8.w),
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    size: 25.sp,
                    Icons.arrow_back,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
    );
  }
}
