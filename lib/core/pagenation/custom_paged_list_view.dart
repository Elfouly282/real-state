// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../constant/custom_button.dart';
// import '../utils/app_texts.dart';
//
// class CustomPagedListView<T> extends StatelessWidget {
//   const CustomPagedListView({
//     super.key,
//     required this.pagingController,
//     required this.itemBuilder,
//     this.emptyMessage = 'No items found',
//     this.padding,
//     this.shrinkWrap = false,
//     this.physics,
//     this.skeletonItem,
//     this.skeletonCount = 5,
//   });
//
//   final PagingController<int, T> pagingController;
//   final Widget Function(BuildContext context, T item, int index) itemBuilder;
//   final String emptyMessage;
//   final EdgeInsetsGeometry? padding;
//   final bool shrinkWrap;
//   final ScrollPhysics? physics;
//   final Widget? skeletonItem;
//   final int skeletonCount;
//
//   @override
//   Widget build(BuildContext context) {
//     return PagedListView<int, T>(
//       pagingController: pagingController,
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
//       shrinkWrap: shrinkWrap,
//       physics: physics ?? const AlwaysScrollableScrollPhysics(),
//       builderDelegate: PagedChildBuilderDelegate<T>(
//         itemBuilder: itemBuilder,
//         firstPageProgressIndicatorBuilder: (_) => skeletonItem != null
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: skeletonCount,
//                 itemBuilder: (context, index) => skeletonItem!,
//               )
//             : Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 50),
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//         newPageProgressIndicatorBuilder: (_) => Padding(
//           padding: EdgeInsets.symmetric(vertical: 24.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(color: AppColors.primaryColor),
//               SizedBox(height: 12.h),
//               Text(
//                 context.tr(AppTexts.loadingMore),
//                 style: getRegularStyle(fontSize: 14.sp, color: AppColors.grey),
//               ),
//             ],
//           ),
//         ),
//         noItemsFoundIndicatorBuilder: (_) => Center(
//           child: Padding(
//             padding: EdgeInsets.only(top: 50.h),
//             child: Text(
//               emptyMessage.tr(),
//               style: getRegularStyle(fontSize: 16.sp, color: AppColors.grey),
//             ),
//           ),
//         ),
//         firstPageErrorIndicatorBuilder: (_) => Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 context.tr(AppTexts.somethingWentWrong),
//                 style: getRegularStyle(
//                   fontSize: 16.sp,
//                   color: AppColors.errorColor,
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               CustomButton(
//                 width: 130.w,
//                 data: context.tr(AppTexts.tryAgain),
//                 onTap: () => pagingController.refresh(),
//               ),
//             ],
//           ),
//         ),
//         newPageErrorIndicatorBuilder: (_) => Center(
//           child: TextButton(
//             onPressed: () => pagingController.retryLastFailedRequest(),
//             child: Text(
//               context.tr(AppTexts.retry),
//               style: getRegularStyle(
//                 fontSize: 16.sp,
//                 color: AppColors.errorColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
