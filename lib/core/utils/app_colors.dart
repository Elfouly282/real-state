import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF0000FF);
  static const Color secondaryColor = Color(0xFF0F1942);
  static const Color blue = Color(0xFF00E6FF);
  static const Color blue2 = Color(0xFF0053BC);
  static const Color green = Color(0xFF008D36);
  static const Color yello = Color(0xFFFAE700);
  static const Color pink = Color(0xFFFF4596);

  static const Color darkColor = Color(0xFF313131);
  static const Color lightGrayColor = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color bordergrey = Color(0xFF777777);
  static const Color grey = Color(0xFFB8B8B8);
  static const Color grey2 = Color(0xFF939AAD);
  static const Color greychip = Color(0xFFEFEFF0);

  static const Color errorColor = Color(0xFFDC3545);
  static const Color successColor = Color(0xFF28A745);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF17A2B8);

  static const Color textPrimaryColor = darkColor;
  static const Color textSecondaryColor = Color(0xFF6C757D);
  static const Color textLightColor = Color(0xFF9E9E9E);
  static const Color textOnPrimaryColor = white;
  static const Color textOnSecondaryColor = darkColor;

  static const Color borderColor = lightGrayColor;
  static const Color dividerColor = lightGrayColor;
  static const Color cardBorderColor = lightGrayColor;

  static const Color shadowColor = Color(0x1A000000);
  static const Color primaryShadowColor = Color(0x4DC67C4E);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xffFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryColor, Color(0xFFE8C4A8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color onlineColor = successColor;
  static const Color offlineColor = Color(0xFF6C757D);
  static const Color pendingColor = warningColor;
  static const Color cancelledColor = errorColor;

  static Color get primaryColorLight => primaryColor.withValues(alpha: 0.1);
  static Color get primaryColorMedium => primaryColor.withValues(alpha: 0.3);
  static Color get primaryColorDark => primaryColor.withValues(alpha: 0.8);

  static Color get secondaryColorLight => secondaryColor.withValues(alpha: 0.1);
  static Color get secondaryColorMedium =>
      secondaryColor.withValues(alpha: 0.3);
  static Color get secondaryColorDark => secondaryColor.withValues(alpha: 0.8);

  static const Color darkwhite = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF2D2D2D);
  static const Color darkBorderColor = Color(0xFF404040);
  static const Color darkTextPrimaryColor = Color(0xFFFFFFFF);
  static const Color darkTextSecondaryColor = Color(0xFFB0B0B0);

  static const LinearGradient blueGradient = LinearGradient(
    colors: [blue, blue2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color getAdaptiveBorderColor(BuildContext context) {
    return borderColor;
  }

  // Payment Feature Colors
  static const Color paymentTeal = Color(0xFF1392A6);
  static const Color darkTeal = Color(0xFF00838F);
  static const Color lightGreenBg = Color(0xFFEFFBEE);
  static const Color darkGreenText = Color(0xFF2E6930);
  static const Color successGreenIcon = Color(0xFF4CAF50);
  static const Color offWhiteBg = Color(0xFFF8F9FA);
  static const Color visaBlue = Color(0xFF1A1F71);
  static const Color lightCyanBtn = Color(0xFFC7F8FF);
  static const Color mastercardRed = Color(0xFFEB001B);
  static const Color mastercardOrange = Color(0xFFF79E1B);
  static const Color bankOfAmericaBlue = Color(0xFF00529B);
  static const Color bankOfAmericaRed = Color(0xFFD1242B);
  static const Color hsbcRed = Color(0xFFDB0011);
  static const Color greenBankColor = Color(0xFF00A859);
}
