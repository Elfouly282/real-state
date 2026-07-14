// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_styles.dart';
//
// class AppHtmlWidget {
//   static Widget renderHtml({
//     required String htmlContent,
//     TextStyle? textStyle,
//     int? maxLines,
//     TextOverflow? overflow,
//     Map<String, Style>? customStyles,
//     EdgeInsetsGeometry? padding,
//     Color? backgroundColor,
//     double? borderRadius,
//   }) {
//     return Container(
//       padding: padding ?? EdgeInsets.zero,
//       decoration: backgroundColor != null || borderRadius != null
//           ? BoxDecoration(
//         color: backgroundColor,
//         borderRadius: borderRadius != null
//             ? BorderRadius.circular(borderRadius.r)
//             : null,
//       )
//           : null,
//       child: Html(
//         data: htmlContent,
//         shrinkWrap: true,
//         style: {
//           // Default styles for common HTML elements
//           "body": Style(
//             margin: Margins.zero,
//             padding: HtmlPaddings.zero,
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//             fontFamily: textStyle?.fontFamily,
//             fontWeight: textStyle?.fontWeight ?? FontWeight.normal,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//             lineHeight: LineHeight(textStyle?.height ?? 1.4),
//           ),
//           "p": Style(
//             margin: Margins.only(bottom: 8.h),
//             fontSize: FontSize(textStyle?.fontSize ?? 18.sp),
//             color: textStyle?.color ?? AppColors.black,
//             fontFamily: textStyle?.fontFamily,
//             fontWeight: textStyle?.fontWeight ?? FontWeight.normal,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//             lineHeight: LineHeight(textStyle?.height ?? 1.4),
//           ),
//           "h1": Style(
//             margin: Margins.only(bottom: 12.h),
//             fontSize: FontSize(32.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.bold,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "h2": Style(
//             margin: Margins.only(bottom: 10.h),
//             fontSize: FontSize(20.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.bold,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "h3": Style(
//             margin: Margins.only(bottom: 8.h),
//             fontSize: FontSize(18.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.w600,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "h4": Style(
//             margin: Margins.only(bottom: 6.h),
//             fontSize: FontSize(16.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.w600,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "h5": Style(
//             margin: Margins.only(bottom: 4.h),
//             fontSize: FontSize(14.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.w600,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "h6": Style(
//             margin: Margins.only(bottom: 4.h),
//             fontSize: FontSize(12.sp),
//             color: AppColors.primaryColor,
//             fontFamily: null,
//             fontWeight: FontWeight.w600,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//           ),
//           "strong": Style(
//             fontWeight: FontWeight.bold,
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//           ),
//           "b": Style(
//             fontWeight: FontWeight.bold,
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//           ),
//           "em": Style(
//             fontStyle: FontStyle.italic,
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//           ),
//           "i": Style(
//             fontStyle: FontStyle.italic,
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//           ),
//           "u": Style(
//             textDecoration: TextDecoration.underline,
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//           ),
//           "a": Style(
//             color: AppColors.primaryColor,
//             textDecoration: TextDecoration.underline,
//             fontWeight: FontWeight.w500,
//           ),
//           "ul": Style(
//             margin: Margins.only(left: 16.w, bottom: 8.h),
//             padding: HtmlPaddings.zero,
//           ),
//           "ol": Style(
//             margin: Margins.only(left: 16.w, bottom: 8.h),
//             padding: HtmlPaddings.zero,
//           ),
//           "li": Style(
//             margin: Margins.only(bottom: 4.h),
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//             fontFamily: textStyle?.fontFamily,
//           ),
//           "blockquote": Style(
//             margin: Margins.symmetric(horizontal: 16.w, vertical: 8.h),
//             padding: HtmlPaddings.all(12.w),
//             border: Border(
//               left: BorderSide(color: AppColors.primaryColor, width: 4.w),
//             ),
//             backgroundColor: AppColors.white,
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//             fontStyle: FontStyle.italic,
//           ),
//           "code": Style(
//             backgroundColor: AppColors.lightGrayColor,
//             padding: HtmlPaddings.symmetric(horizontal: 4.w, vertical: 2.h),
//             fontSize: FontSize((textStyle?.fontSize ?? 14.sp) * 0.9),
//             fontFamily: 'monospace',
//             color: AppColors.textPrimaryColor,
//           ),
//           "pre": Style(
//             backgroundColor: AppColors.lightGrayColor,
//             padding: HtmlPaddings.all(12.w),
//             margin: Margins.symmetric(vertical: 8.h),
//             fontSize: FontSize((textStyle?.fontSize ?? 14.sp) * 0.9),
//             fontFamily: 'monospace',
//             color: AppColors.textPrimaryColor,
//             whiteSpace: WhiteSpace.pre,
//           ),
//           "table": Style(
//             border: Border.all(color: AppColors.borderColor),
//             margin: Margins.symmetric(vertical: 8.h),
//           ),
//           "th": Style(
//             backgroundColor: AppColors.lightGrayColor,
//             padding: HtmlPaddings.all(8.w),
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimaryColor,
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             border: Border.all(color: AppColors.borderColor),
//           ),
//           "td": Style(
//             padding: HtmlPaddings.all(8.w),
//             color: AppColors.textPrimaryColor,
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             border: Border.all(color: AppColors.borderColor),
//           ),
//           "img": Style(
//             width: Width(100, Unit.percent),
//             height: Height.auto(),
//             margin: Margins.symmetric(vertical: 8.h),
//           ),
//           "div": Style(
//             margin: Margins.zero,
//             padding: HtmlPaddings.zero,
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//             fontFamily: textStyle?.fontFamily,
//             fontWeight: textStyle?.fontWeight ?? FontWeight.normal,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//             lineHeight: LineHeight(textStyle?.height ?? 1.4),
//           ),
//           "span": Style(
//             fontSize: FontSize(textStyle?.fontSize ?? 14.sp),
//             color: textStyle?.color ?? AppColors.textPrimaryColor,
//             fontFamily: textStyle?.fontFamily,
//             fontWeight: textStyle?.fontWeight ?? FontWeight.normal,
//             maxLines: maxLines,
//             textOverflow: overflow ?? TextOverflow.ellipsis,
//             lineHeight: LineHeight(textStyle?.height ?? 1.4),
//           ),
//           // Merge custom styles if provided
//           ...?customStyles,
//         },
//         onLinkTap: (url, _, _) {
//           // Handle link taps if needed
//           if (url != null) {
//             // You can add URL launcher functionality here
//             debugPrint('Link tapped: $url');
//           }
//         },
//       ),
//     );
//   }
//
//   /// Renders HTML content for product descriptions
//   static Widget renderProductDescription({
//     required String htmlContent,
//     int maxLines = 3,
//     TextOverflow overflow = TextOverflow.ellipsis,
//   }) {
//     return renderHtml(
//       htmlContent: htmlContent,
//       textStyle: getRegularStyle(
//         fontSize: 14.sp,
//         color: AppColors.black,
//         height: 1.4,
//       ),
//       maxLines: maxLines,
//       overflow: overflow,
//       customStyles: {
//         'p': Style(
//           margin: Margins.zero,
//           fontSize: FontSize(14.sp),
//           color: AppColors.black,
//           maxLines: maxLines,
//           textOverflow: overflow,
//           lineHeight: LineHeight(1.4),
//         ),
//       },
//     );
//   }
//
//   /// Renders HTML content for product titles
//   static Widget renderProductTitle({
//     required String htmlContent,
//     int maxLines = 2,
//     TextOverflow overflow = TextOverflow.ellipsis,
//   }) {
//     return renderHtml(
//       htmlContent: htmlContent,
//       textStyle: getMediumStyle(
//         fontSize: 16.sp,
//         color: AppColors.textPrimaryColor,
//         height: 1.2,
//       ),
//       maxLines: maxLines,
//       overflow: overflow,
//       customStyles: {
//         'p': Style(
//           margin: Margins.zero,
//           fontSize: FontSize(16.sp),
//           color: AppColors.textPrimaryColor,
//           fontWeight: FontWeight.w600,
//           maxLines: maxLines,
//           textOverflow: overflow,
//           lineHeight: LineHeight(1.2),
//         ),
//       },
//     );
//   }
//
//   /// Renders HTML content for rich text content
//   static Widget renderRichText({
//     required String htmlContent,
//     TextStyle? textStyle,
//     int? maxLines,
//     TextOverflow? overflow,
//   }) {
//     return renderHtml(
//       htmlContent: htmlContent,
//       textStyle:
//       textStyle ??
//           getRegularStyle(
//             fontSize: 14.sp,
//             color: AppColors.textPrimaryColor,
//             height: 1.6,
//           ),
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
// }
