import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';

class ReviewDataStepBody extends StatefulWidget {
  final PropertySummaryEntity propertySummary;

  const ReviewDataStepBody({super.key, required this.propertySummary});

  @override
  State<ReviewDataStepBody> createState() => _ReviewDataStepBodyState();
}

class _ReviewDataStepBodyState extends State<ReviewDataStepBody> {
  late String appointmentDate;
  int personCount = 4;

  @override
  void initState() {
    super.initState();
    appointmentDate = widget.propertySummary.appointmentDate.isNotEmpty
        ? widget.propertySummary.appointmentDate
        : '12 September 2025 - 09.00';
  }

  Future<void> _selectAppointment(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.paymentTeal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && context.mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 9, minute: 0),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.paymentTeal,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedDay = DateFormat('dd MMMM yyyy').format(pickedDate);
        final formattedHour = pickedTime.hour.toString().padLeft(2, '0');
        final formattedMinute = pickedTime.minute.toString().padLeft(2, '0');
        setState(() {
          appointmentDate = '$formattedDay - $formattedHour.$formattedMinute';
        });
      }
    }
  }

  Future<void> _selectPersonCount(BuildContext context) async {
    int tempCount = personCount;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                'Select Number of Persons',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: tempCount > 1
                        ? () => setModalState(() => tempCount--)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppColors.paymentTeal,
                    iconSize: 32.r,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '$tempCount person${tempCount > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  IconButton(
                    onPressed: () => setModalState(() => tempCount++),
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppColors.paymentTeal,
                    iconSize: 32.r,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.paymentTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      personCount = tempCount;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.r),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90.w,
              height: 90.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.network(
                  widget.propertySummary.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.propertySummary.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.propertySummary.address,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.star_border, size: 20.r),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.propertySummary.rate} Rating ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '(${widget.propertySummary.reviews} Reviews)',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(height: 40.h),
        Text(
          AppConstants.bookingDetail,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        SizedBox(height: 20.h),
        BookingDetailRowItem(
          title: AppConstants.bookAppointment,
          subtitle: appointmentDate,
          onEditTap: () => _selectAppointment(context),
        ),
        SizedBox(height: 16.h),
        BookingDetailRowItem(
          title: 'Person',
          subtitle: '$personCount person${personCount > 1 ? 's' : ''}',
          onEditTap: () => _selectPersonCount(context),
        ),
        Divider(height: 40.h),
        Text(
          AppConstants.priceDetails,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        SizedBox(height: 20.h),
        ReviewPriceRowItem(
          label: AppConstants.housePrices,
          value: '\$${widget.propertySummary.price}',
        ),
        SizedBox(height: 12.h),
        ReviewPriceRowItem(
          label: AppConstants.habiSpaceServiceFee,
          value: '\$${widget.propertySummary.serviceFee.ceil().toString()}',
        ),
        Divider(height: 32.h),
        ReviewPriceRowItem(
          label: AppConstants.total,
          value: '\$${widget.propertySummary.totalPrice.ceil().toString()}',
          isBold: true,
        ),
        Divider(height: 40.h),
        Text(
          AppConstants.cancellationPolicy,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        SizedBox(height: 16.h),
        ReadMoreText(
          widget.propertySummary.description,
          trimMode: TrimMode.Line,
          trimLines: 2,
          trimCollapsedText: ' Read more',
          trimExpandedText: ' Show less',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[600],
            height: 1.4,
          ),
          moreStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkTeal,
          ),
          lessStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkTeal,
          ),
        ),
      ],
    );
  }
}

class BookingDetailRowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onEditTap;

  const BookingDetailRowItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            ),
          ],
        ),
        GestureDetector(
          onTap: onEditTap,
          child: Text(
            'Edit',
            style: TextStyle(
              color: AppColors.paymentTeal,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewPriceRowItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const ReviewPriceRowItem({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18.sp : 16.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18.sp : 16.sp,
          ),
        ),
      ],
    );
  }
}
