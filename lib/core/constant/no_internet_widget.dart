// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../gen/assets.gen.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_styles.dart';
// import '../utils/app_texts.dart';
// import 'custom_button.dart';
// import 'custom_svg_image.dart';
//
// class NoInternetWidget extends StatelessWidget {
//   const NoInternetWidget({super.key, this.onTap});
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomSvgImage(
//               path: Assets.svg.noInternet,
//               height: 360.h,
//               width: 450.w,
//             ),
//             Text(
//               context.tr(AppTexts.noInternetLostConnection),
//               style: getHighStyle(fontSize: 24.sp, color: AppColors.black),
//             ),
//             Text(
//               context.tr(AppTexts.noInternetMessage),
//               style: const TextStyle(color: AppColors.grey),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16.h),
//             CustomButton(
//               width: 150.w,
//               data: context.tr(AppTexts.tryAgain),
//               onTap: onTap,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
