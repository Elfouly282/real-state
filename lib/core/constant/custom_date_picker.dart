// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../gen/assets.gen.dart';
// import '../utils/app_colors.dart';
// import 'app_fonts.dart';
//
// class CustomDatePicker extends StatefulWidget {
//   const CustomDatePicker({
//     required this.onDateSelected,
//     this.labelText,
//     this.hintText,
//     this.initialDate,
//     this.minDate,
//     this.maxDate,
//     this.validator,
//     super.key,
//   });
//
//   final Function(DateTime) onDateSelected;
//   final String? labelText;
//   final String? hintText;
//   final DateTime? initialDate;
//   final DateTime? minDate;
//   final DateTime? maxDate;
//   final String? Function(DateTime?)? validator;
//
//   @override
//   State<CustomDatePicker> createState() => CustomDatePickerState();
// }
//
// class CustomDatePickerState extends State<CustomDatePicker> {
//   DateTime? _selectedDate;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.initialDate;
//   }
//
//   void _showDatePicker() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => DatePickerModal(
//         labelText: widget.labelText,
//         selectedDate: _selectedDate,
//         initialDate: widget.initialDate,
//         minDate: widget.minDate,
//         maxDate: widget.maxDate,
//         onDateSelected: (date) {
//           setState(() {
//             _selectedDate = date;
//             _errorMessage = null;
//           });
//           widget.onDateSelected(date);
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.labelText != null) _DatePickerLabel(text: widget.labelText!),
//         DatePickerField(
//           selectedDate: _selectedDate,
//           hintText: widget.hintText,
//           errorMessage: _errorMessage,
//           onTap: _showDatePicker,
//         ),
//         if (_errorMessage != null) _DatePickerError(message: _errorMessage!),
//       ],
//     );
//   }
//
//   void validate() {
//     if (widget.validator != null) {
//       final error = widget.validator!(_selectedDate);
//       setState(() {
//         _errorMessage = error;
//       });
//     }
//   }
//
//   DateTime? get selectedDate => _selectedDate;
// }
//
// class DatePickerField extends StatelessWidget {
//   const DatePickerField({
//     required this.selectedDate,
//     required this.hintText,
//     required this.errorMessage,
//     required this.onTap,
//     super.key,
//   });
//
//   final DateTime? selectedDate;
//   final String? hintText;
//   final String? errorMessage;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsetsDirectional.symmetric(
//           horizontal: 12.w,
//           vertical: 14.h,
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: errorMessage != null
//                 ? AppColors.errorColor
//                 : AppColors.borderColor,
//             width: errorMessage != null ? 1.5 : 1,
//           ),
//           borderRadius: BorderRadius.circular(48.r),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 selectedDate != null
//                     ? _DateFormatter.format(selectedDate!)
//                     : hintText ?? 'Select date',
//                 style: selectedDate != null
//                     ? AppFonts.inputTextStyle(color: AppColors.textPrimaryColor)
//                     : AppFonts.bodyMediumStyle(color: AppColors.textLightColor),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//
//             SizedBox(width: 10.w),
//
//             CustomSvgImage(path: Assets.svg.date),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DatePickerModal extends StatefulWidget {
//   const DatePickerModal({
//     required this.onDateSelected,
//     this.labelText,
//     this.selectedDate,
//     this.initialDate,
//     this.minDate,
//     this.maxDate,
//     super.key,
//   });
//
//   final Function(DateTime) onDateSelected;
//   final String? labelText;
//   final DateTime? selectedDate;
//   final DateTime? initialDate;
//   final DateTime? minDate;
//   final DateTime? maxDate;
//
//   @override
//   State<DatePickerModal> createState() => _DatePickerModalState();
// }
//
// class _DatePickerModalState extends State<DatePickerModal> {
//   late DateTime? _tempSelectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _tempSelectedDate = widget.selectedDate ?? widget.initialDate;
//   }
//
//   void _handleDateSelection(DateTime date) {
//     setState(() {
//       _tempSelectedDate = date;
//     });
//   }
//
//   void _handleDone() {
//     if (_tempSelectedDate != null) {
//       widget.onDateSelected(_tempSelectedDate!);
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24.r),
//           topRight: Radius.circular(24.r),
//         ),
//       ),
//       child: Column(
//         children: [
//           DatePickerHeader(
//             labelText: widget.labelText,
//             onCancel: () => Navigator.pop(context),
//             onDone: _handleDone,
//             canDone: _tempSelectedDate != null,
//           ),
//           Expanded(
//             child: DatePickerCalendar(
//               selectedDate: _tempSelectedDate,
//               initialDate: widget.initialDate,
//               minDate: widget.minDate,
//               maxDate: widget.maxDate,
//               onDateSelected: _handleDateSelection,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DatePickerHeader extends StatelessWidget {
//   const DatePickerHeader({
//     required this.onCancel,
//     required this.onDone,
//     required this.canDone,
//     this.labelText,
//     super.key,
//   });
//
//   final String? labelText;
//   final VoidCallback onCancel;
//   final VoidCallback onDone;
//   final bool canDone;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: AppColors.borderColor, width: 1),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextButton(
//             onPressed: onCancel,
//             child: Text(
//               'Cancel',
//               style: AppFonts.bodyMediumStyle(
//                 color: AppColors.textSecondaryColor,
//               ),
//             ),
//           ),
//           Text(
//             labelText ?? 'Select Date',
//             style: AppFonts.titleLargeStyle(color: AppColors.primaryColor),
//           ),
//           TextButton(
//             onPressed: canDone ? onDone : null,
//             child: Text(
//               'Done',
//               style: AppFonts.bodyMediumStyle(
//                 color: AppColors.primaryColor,
//               ).copyWith(fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DatePickerCalendar extends StatelessWidget {
//   const DatePickerCalendar({
//     required this.onDateSelected,
//     this.selectedDate,
//     this.initialDate,
//     this.minDate,
//     this.maxDate,
//     super.key,
//   });
//
//   final Function(DateTime) onDateSelected;
//   final DateTime? selectedDate;
//   final DateTime? initialDate;
//   final DateTime? minDate;
//   final DateTime? maxDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return SfDateRangePicker(
//       initialSelectedDate: selectedDate ?? initialDate,
//       minDate: minDate ?? DateTime(1900),
//       maxDate: maxDate ?? DateTime.now(),
//       selectionMode: DateRangePickerSelectionMode.single,
//       onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
//         if (args.value is DateTime) {
//           onDateSelected(args.value as DateTime);
//         }
//       },
//       headerStyle: DateRangePickerHeaderStyle(
//         textStyle: AppFonts.titleLargeStyle(color: AppColors.textPrimaryColor),
//         backgroundColor: AppColors.white,
//       ),
//       monthViewSettings: DateRangePickerMonthViewSettings(
//         firstDayOfWeek: 6, // Saturday
//         viewHeaderStyle: DateRangePickerViewHeaderStyle(
//           textStyle: AppFonts.bodyMediumStyle(
//             color: AppColors.textSecondaryColor,
//           ),
//           backgroundColor: AppColors.white,
//         ),
//       ),
//       selectionColor: AppColors.primaryColor,
//       todayHighlightColor: AppColors.primaryColorLight,
//       rangeSelectionColor: AppColors.primaryColorLight,
//       startRangeSelectionColor: AppColors.primaryColor,
//       endRangeSelectionColor: AppColors.primaryColor,
//       selectionTextStyle: AppFonts.bodyMediumStyle(
//         color: AppColors.white,
//       ).copyWith(fontWeight: FontWeight.w600),
//       monthCellStyle: DateRangePickerMonthCellStyle(
//         textStyle: AppFonts.bodyMediumStyle(color: AppColors.textPrimaryColor),
//         todayTextStyle: AppFonts.bodyMediumStyle(
//           color: AppColors.primaryColor,
//         ).copyWith(fontWeight: FontWeight.w600),
//       ),
//       backgroundColor: AppColors.white,
//     );
//   }
// }
//
// class _DatePickerLabel extends StatelessWidget {
//   const _DatePickerLabel({required this.text});
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(bottom: 5.h),
//       child: Text(
//         text,
//         style: AppFonts.titleLargeStyle(color: AppColors.primaryColor),
//       ),
//     );
//   }
// }
//
// class _DatePickerError extends StatelessWidget {
//   const _DatePickerError({required this.message});
//
//   final String message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(top: 4.h, start: 12.w),
//       child: Text(
//         message,
//         style: AppFonts.labelSmallStyle(
//           color: AppColors.errorColor,
//         ).copyWith(height: 1.h),
//       ),
//     );
//   }
// }
//
// class _DateFormatter {
//   static String format(DateTime date) {
//     return DateFormat('dd / MM / yyyy').format(date);
//   }
// }
