import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
        surface: AppColors.white,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onError: AppColors.white,
        onSurface: AppColors.textPrimaryColor,
      ),

      scaffoldBackgroundColor: AppColors.scaffoldBg,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        actionsIconTheme: const IconThemeData(color: AppColors.secondaryColor),
        titleTextStyle: getBoldStyle(
          fontSize: AppFonts.titleMedium,
          color: AppColors.secondaryColor,
        ),
        shadowColor: AppColors.shadowColor,
        shape: const Border(
          bottom: BorderSide(color: AppColors.greychip, width: 1),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: getBoldStyle(
            fontSize: AppFonts.displayLarge, color: AppColors.textPrimaryColor),
        displayMedium: getBoldStyle(
            fontSize: AppFonts.displayMedium, color: AppColors.textPrimaryColor),
        displaySmall: getBoldStyle(
            fontSize: AppFonts.displaySmall, color: AppColors.textPrimaryColor),
        headlineLarge: getBoldStyle(
            fontSize: AppFonts.headlineLarge, color: AppColors.textPrimaryColor),
        headlineMedium: getBoldStyle(
            fontSize: AppFonts.headlineMedium,
            color: AppColors.textPrimaryColor),
        headlineSmall: getBoldStyle(
            fontSize: AppFonts.headlineSmall, color: AppColors.textPrimaryColor),
        titleLarge: getMediumStyle(
            fontSize: AppFonts.titleLarge, color: AppColors.textPrimaryColor),
        titleMedium: getMediumStyle(
            fontSize: AppFonts.titleMedium, color: AppColors.textPrimaryColor),
        titleSmall: getMediumStyle(
            fontSize: AppFonts.titleSmall, color: AppColors.textPrimaryColor),
        bodyLarge: getRegularStyle(
            fontSize: AppFonts.bodyLarge, color: AppColors.textPrimaryColor),
        bodyMedium: getRegularStyle(
            fontSize: AppFonts.bodyMedium, color: AppColors.textPrimaryColor),
        bodySmall: getRegularStyle(
            fontSize: AppFonts.bodySmall, color: AppColors.textSecondaryColor),
        labelLarge: getMediumStyle(
            fontSize: AppFonts.labelLarge, color: AppColors.textSecondaryColor),
        labelMedium: getRegularStyle(
            fontSize: AppFonts.labelMedium,
            color: AppColors.textSecondaryColor),
        labelSmall: getRegularStyle(
            fontSize: AppFonts.labelSmall, color: AppColors.textLightColor),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightGrayColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        hintStyle: getSmallStyle(
            fontSize: AppFonts.bodyMedium, color: AppColors.textLightColor),
        labelStyle: getRegularStyle(
            fontSize: AppFonts.labelLarge, color: AppColors.secondaryColor),
        errorStyle: getSmallStyle(
            fontSize: AppFonts.labelSmall, color: AppColors.errorColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          textStyle: getBoldStyle(
              fontSize: AppFonts.buttonTextSize, color: AppColors.white),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: getMediumStyle(
              fontSize: AppFonts.bodyMedium, color: AppColors.primaryColor),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          textStyle: getMediumStyle(
              fontSize: AppFonts.bodyMedium, color: AppColors.primaryColor),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.secondaryColor,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        shape: CircleBorder(),
      ),

      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.greychip, width: 1),
        ),
        shadowColor: AppColors.shadowColor,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.greychip,
        labelStyle: getMediumStyle(
            fontSize: AppFonts.labelSmall, color: AppColors.textPrimaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.greychip,
        thickness: 1,
        space: 1,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        titleTextStyle: getBoldStyle(
            fontSize: AppFonts.titleSmall, color: AppColors.secondaryColor),
        contentTextStyle: getRegularStyle(
            fontSize: AppFonts.bodyMedium, color: AppColors.textPrimaryColor),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.secondaryColor,
        contentTextStyle: getRegularStyle(
            fontSize: AppFonts.bodyMedium, color: AppColors.white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      listTileTheme: ListTileThemeData(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        titleTextStyle: getRegularStyle(
            fontSize: AppFonts.bodyMedium, color: AppColors.textPrimaryColor),
        subtitleTextStyle: getRegularStyle(
            fontSize: AppFonts.bodySmall,
            color: AppColors.textSecondaryColor),
        iconColor: AppColors.primaryColor,
      ),

      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.tableHeaderBg),
        dataRowColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor.withValues(alpha: 0.06);
          }
          return null;
        }),
        headingTextStyle: TextStyle(
          fontSize: AppFonts.labelMedium,
          fontWeight: FontWeightManager.semiBold,
          color: AppColors.secondaryColor,
          letterSpacing: 0.5,
          fontFamily: AppFonts.questFont,
        ),
        dataTextStyle: TextStyle(
          fontSize: AppFonts.bodySmall,
          fontWeight: FontWeightManager.light,
          color: AppColors.textSecondaryColor,
          fontFamily: AppFonts.questFont,
        ),
        headingRowHeight: 46,
        dataRowMinHeight: 54,
        dataRowMaxHeight: 64,
        dividerThickness: 1.2,
        columnSpacing: 24,
        horizontalMargin: 20,
        checkboxHorizontalMargin: 16,
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.grey,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryColorLight
              : AppColors.greychip,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(AppColors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }
}
