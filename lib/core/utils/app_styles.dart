import 'package:flutter/material.dart';
import 'app_fonts.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color? color,
  double? height,
  TextDecoration? decoration,
) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    height: height,
    decoration: decoration,
    fontFamily: AppFonts.questFont,
  );
}

TextStyle getSmallStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w200, color, height, decoration);
}

TextStyle getLightStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w400, color, height, decoration);
}

TextStyle getRegularStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w400, color, height, decoration);
}

TextStyle getMediumStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w600, color, height, decoration);
}

TextStyle getHighStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w700, color, height, decoration);
}

TextStyle getBoldStyle({
  required double fontSize,
  required Color color,
  double? height,
  TextDecoration? decoration,
}) {
  return _getTextStyle(fontSize, FontWeight.w700, color, height, decoration);
}

TextDirection getTextDirectionFromText(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

({TextDirection direction, TextAlign align}) getTextDirectionAndAlignFromText(
  String text,
) {
  final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  return (
    direction: isArabic ? TextDirection.rtl : TextDirection.ltr,
    align: isArabic ? TextAlign.right : TextAlign.left,
  );
}
