// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../gen/assets.gen.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_styles.dart';
// import 'custom_button.dart';
// import 'custom_svg_image.dart';
//
// class NoAccountWidget extends StatelessWidget {
//   const NoAccountWidget({super.key, this.onTap});
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
//               path: Assets.svg.noaccount,
//               height: 360.h,
//               width: 450.w,
//             ),
//             Text(
//               "Unauthenticated",
//               style: getHighStyle(fontSize: 24.sp, color: AppColors.black),
//             ),
//             Text(
//               "Please login to continue",
//               style: const TextStyle(color: AppColors.grey),
//             ),
//             SizedBox(height: 16.h),
//
//             CustomButton(width: 150.w, data: "Try again", onTap: onTap),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
