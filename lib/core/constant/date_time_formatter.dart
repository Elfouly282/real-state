// import 'package:intl/intl.dart';
//
// class DateTimeFormatter {
//   static String formatTime(String timeString) {
//     try {
//       final time = DateTime.parse("2023-01-01 $timeString");
//       return DateFormat('h:mm a').format(time);
//     } catch (e) {
//       return timeString;
//     }
//   }
//
//   static String formatDate(DateTime date) {
//     return DateFormat('MM-dd-yyyy').format(date);
//   }
//
//   static String formatDateFull(DateTime date) {
//     return DateFormat('EEEE, MMMM d, yyyy').format(date);
//   }
//
//   static String formatDateShort(DateTime date) {
//     return DateFormat('MM/dd/yyyy').format(date);
//   }
//
//   static String formatDateTime(DateTime dateTime) {
//     return DateFormat('MM-dd-yyyy h:mm a').format(dateTime);
//   }
//
//   static String formatWorkingHours(String? start, String? end) {
//     if (start == null || end == null || start.isEmpty || end.isEmpty) {
//       return '';
//     }
//     final formattedStart = formatTime(start);
//     final formattedEnd = formatTime(end);
//     return '$formattedStart - $formattedEnd';
//   }
// }
