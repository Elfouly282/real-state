import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.data,
    this.width,
    this.fontSize,
    this.color,
    this.height,
    this.txtcolor,
    this.bordercolor,
    this.isLoading = false,
    this.icon,
    this.icon2,
    this.borderRadius,
  });

  final void Function()? onTap;
  final String? data;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final Color? txtcolor;
  final Color? bordercolor;
  final bool isLoading;
  final Widget? icon;
  final Widget? icon2;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular((borderRadius ?? 10).r),
      child: Container(
        height: height ?? 60.h,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          border: Border.all(
            color: bordercolor ?? AppColors.primaryColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular((borderRadius ?? 10).r),
        ),
        child: Center(
          child: ConditionalBuilder(
            condition: !isLoading,
            builder: (context) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon!, SizedBox(width: 8.w)],

                Text(
                  data ?? "",
                  style: getBoldStyle(
                    fontSize: fontSize ?? 24,
                    color: txtcolor ?? AppColors.white,
                  ),
                ),

                if (icon2 != null) ...[SizedBox(width: 8.w), icon2!],
              ],
            ),
            fallback: (context) => SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                color: txtcolor ?? Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
