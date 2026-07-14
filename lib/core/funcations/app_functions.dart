import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:page_transition/page_transition.dart';

import '../constant/app_constants.dart';
import '../save data/save_data.dart';

class AppFunctions {
  static String reverseString(String originalString) {
    List<String> charList = originalString.split('');
    List<String> reversedList = charList.reversed.toList();
    String reversedString = reversedList.join();

    debugPrint('Original String: $originalString');
    debugPrint('Reversed String: $reversedString');

    return reversedString;
  }

  static void showsToast(
    String text,
    Color color,
    BuildContext context, {
    int seconds = 5,
  }) {
    showToast(
      text,
      context: context,
      backgroundColor: color,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 400),
      duration: Duration(seconds: seconds),
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInOutCirc,
    );
  }

  static String prettyTime(String timeString) {
    DateTime time = DateTime.parse("2023-01-01 $timeString");

    String formattedTime = DateFormat('h:mm a').format(time);

    return formattedTime;
  }

  static String prettyDate(String dateString) {
    DateTime date = DateTime.parse(dateString);

    String formattedTime = DateFormat('MM-dd-yyyy').format(date);

    return formattedTime;
  }

  static String formatReviewDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final fallback =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    if (difference.isNegative) {
      return fallback;
    }

    if (difference.inDays == 0) {
      return 'Just now';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      if (weeks == 1) {
        return '1 week ago';
      } else if (weeks == 2) {
        return '2 weeks ago';
      } else {
        return '$weeks weeks ago';
      }
    } else {
      return fallback;
    }
  }

  static bool pickerActive = false;

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  static Route<T> fadeRoute<T>(Widget screen) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Future<void> navigateTo(
    BuildContext context,
    Widget screen, [
    PageTransitionType type = PageTransitionType.fade,
  ]) async {
    // Always use fade transition on all platforms
    await Navigator.of(context).push(fadeRoute(screen));
  }

  static Future<T?> navigateForResult<T>(
    BuildContext context,
    Widget screen,
  ) async {
    return Navigator.of(context).push<T>(fadeRoute<T>(screen));
  }

  static void navigateToAndReplacement(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(fadeRoute(screen));
  }

  static void navigateToAndFinish(BuildContext context, Widget screen) {
    Navigator.of(
      context,
    ).pushAndRemoveUntil(fadeRoute(screen), (route) => false);
  }

  static void popThenNavigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.of(context).push(fadeRoute(screen));
  }

  static String convertArabicDigitsToEnglish(String text) {
    final Map<String, String> arabicToEnglishDigits = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    String result = '';
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (arabicToEnglishDigits.containsKey(char)) {
        result += arabicToEnglishDigits[char]!;
      } else {
        result += char;
      }
    }

    return result;
  }

  static String getLanguageCode() {
    final savedLanguage = CacheHelper().getDataString(key: 'language');

    if (savedLanguage != null) {
      return savedLanguage;
    }

    try {
      final deviceLocale = Platform.localeName;
      if (deviceLocale.startsWith('ar')) {
        return AppConstants.arabicLangCode;
      } else {
        return AppConstants.englishLangCode;
      }
    } catch (e) {
      return AppConstants.arabicLangCode;
    }
  }

  static Locale getLocale() {
    final languageCode = getLanguageCode();

    if (languageCode == AppConstants.arabicLangCode) {
      return const Locale('ar', 'SA');
    } else {
      return const Locale('en', 'US');
    }
  }

  static Color hexToColor(String hex) {
    if (hex.isEmpty) {
      return const Color(0xFF000000); // Default to black if empty
    }
    hex = hex.replaceAll('#', '').trim();

    // If already in 0xff format, remove prefix and parse
    if (hex.startsWith('0xff') || hex.startsWith('0xFF')) {
      hex = hex.substring(4);
    }

    // If 6 digits, add ff prefix for alpha
    if (hex.length == 6) {
      hex = 'ff$hex';
    }

    return Color(int.parse('0x$hex'));
  }

  static String convertHexToFlutterFormat(String hex) {
    if (hex.isEmpty) {
      return '0xff000000'; // Default to black if empty
    }
    hex = hex.replaceAll('#', '').trim();

    // If already in 0xff format, return as is
    if (hex.startsWith('0xff') || hex.startsWith('0xFF')) {
      return hex;
    }

    // If 6 digits, add 0xff prefix
    if (hex.length == 6) {
      return '0xff$hex';
    }

    // If 8 digits (with alpha), add 0x prefix
    if (hex.length == 8) {
      return '0x$hex';
    }

    // Fallback: pad to 6 digits and add 0xff
    if (hex.length < 6) {
      hex = hex.padRight(6, '0');
    }
    return '0xff${hex.substring(0, 6)}';
  }

  String colorToHex(Color color) {
    final int argb = color.toARGB32();
    return '0x${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}
