import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_styles.dart';

class CustomTextformfeild extends StatefulWidget {
  const CustomTextformfeild({
    required this.keyboardType,
    required this.controller,
    required this.validator,
    required this.formFieldKey,
    this.borderRadius,
    this.hintText,
    this.labelText,
    this.labelcolor,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.isPhoneField = false,
    this.errorText,
    this.onChanged,
    super.key,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final Key? formFieldKey;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final bool isPhoneField;
  final Color? labelcolor;
  final double? borderRadius;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  State<CustomTextformfeild> createState() => _CustomTextformfeildState();
}

class _CustomTextformfeildState extends State<CustomTextformfeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    if (widget.isPhoneField && widget.prefixText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 5.h),
              child: Text(
                widget.labelText!,
                style: getRegularStyle(
                  fontSize: AppFonts.labelLarge,
                  color: widget.labelcolor ?? AppColors.secondaryColor,
                ),
              ),
            ),
          Row(
            children: [
              Container(
                width: 55.w,
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Center(
                  child: Text(
                    widget.prefixText!,
                    style: getLightStyle(
                      fontSize: AppFonts.inputText,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 4.w),

              Expanded(child: _buildTextField(isRTL)),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 5.h),
            child: Text(
              widget.labelText!,
              style: getRegularStyle(
                fontSize: AppFonts.labelLarge,
                color: widget.labelcolor ?? AppColors.secondaryColor,
              ),
            ),
          ),
        _buildTextField(isRTL),
      ],
    );
  }

  Widget _buildTextField(bool isRTL) {
    return TextFormField(
      key: widget.formFieldKey,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      textAlign: isRTL ? TextAlign.right : TextAlign.left,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: getLightStyle(
        fontSize: AppFonts.inputText,
        color: AppColors.textPrimaryColor,
      ),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: getSmallStyle(
          fontSize: AppFonts.bodyMedium,
          color: AppColors.textLightColor,
        ),
        filled: true,
        fillColor: AppColors.lightGrayColor,
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 12.w,
          vertical: 14.h,
        ),
        errorStyle: getSmallStyle(
          fontSize: AppFonts.labelSmall,
          color: AppColors.errorColor,
          height: 1,
        ),
        helperText: null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: BoxConstraints(minWidth: 10.w, minHeight: 10.h),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondaryColor,
                  size: 24.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon != null
            ? SizedBox(
                width: 10.w,
                height: 10.h,
                child: Center(child: widget.suffixIcon!),
              )
            : null,
      ),
    );
  }
}
