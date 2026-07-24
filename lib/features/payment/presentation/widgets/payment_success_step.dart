import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';
import 'package:real_state/features/payment/presentation/widgets/receipt_pdf_service.dart';

class PaymentSuccessStepBody extends StatelessWidget {
  final PropertySummaryEntity propertySummary;
  final String name;
  // final String amount;
  final String accountNumber;
  // final String paymentDate;
  final String paymentMethod;
  // final String senderName;
  // final String housePrice;
  // final String serviceFee;
  // final String realEstateTitle;
  // final String appointmentDate;

  const PaymentSuccessStepBody({
    required this.propertySummary,
    super.key,
    // this.amount = '\$120.250',
    this.accountNumber = '2618085752257',
    // this.paymentDate = 'Sept 9, 2025, 09:41:13',
    this.paymentMethod = AppConstants.bankTransfer,
    // this.senderName = 'Wade Warren',
    // this.housePrice = '120.000',
    // this.serviceFee = '250',
    // this.realEstateTitle = 'SunnySlade House',
    // this.appointmentDate = '12 Sept 2025 - 09.00',
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      children: [
        PaymentSuccessHeader(
          amount: propertySummary.totalPrice.toString(),
          statusText: AppConstants.paymentSuccessful,
        ),
        SizedBox(height: 24.h),
        Divider(height: 1.h, color: const Color(0xFFEEEEEE)),
        SizedBox(height: 24.h),
        TransactionDetailsSection(
          accountNumber: accountNumber,
          paymentDate: propertySummary.appointmentDate,
          paymentMethod: paymentMethod,
          senderName: name,
        ),
        SizedBox(height: 24.h),
        Divider(height: 1.h, color: const Color(0xFFEEEEEE)),
        SizedBox(height: 24.h),
        PaymentSummaryPriceSection(
          housePrice: propertySummary.price,
          serviceFee: propertySummary.serviceFee.toString(),
        ),
        SizedBox(height: 24.h),
        Divider(height: 1.h, color: const Color(0xFFEEEEEE)),
        SizedBox(height: 24.h),
        RealEstateBookingSummarySection(
          realEstateTitle: propertySummary.title,
          appointmentDate: propertySummary.appointmentDate,
        ),
        SizedBox(height: 32.h),
        DownloadReceiptButton(
          onPressed: () {
            ReceiptPdfService.generateAndDownloadReceipt(
              amount: propertySummary.totalPrice.toString(),
              // name: name,
              accountNumber: accountNumber,
              paymentDate: propertySummary.appointmentDate,
              paymentMethod: paymentMethod,
              senderName: name,
              housePrice: propertySummary.price,
              serviceFee: propertySummary.serviceFee.toString(),
              realEstateTitle: propertySummary.title,
              appointmentDate: propertySummary.appointmentDate,
            );
          },
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class PaymentSuccessHeader extends StatelessWidget {
  final String amount;
  final String statusText;

  const PaymentSuccessHeader({
    super.key,
    required this.amount,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Container(
          width: 80.w,
          height: 80.h,
          decoration: const BoxDecoration(
            color: AppColors.lightGreenBg,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.check_circle,
              size: 48.r,
              color: AppColors.successGreenIcon,
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          amount,
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class TransactionDetailsSection extends StatelessWidget {
  final String accountNumber;
  final String paymentDate;
  final String paymentMethod;
  final String senderName;

  const TransactionDetailsSection({
    super.key,
    required this.accountNumber,
    required this.paymentDate,
    required this.paymentMethod,
    required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReceiptDetailRow(
          label: AppConstants.accountNumber,
          value: accountNumber,
        ),
        SizedBox(height: 14.h),
        ReceiptDetailRow(label: AppConstants.paymentDate, value: paymentDate),
        SizedBox(height: 14.h),
        ReceiptDetailRow(
          label: AppConstants.paymentMethod,
          value: paymentMethod,
        ),
        SizedBox(height: 14.h),
        ReceiptDetailRow(label: AppConstants.sendersName, value: senderName),
      ],
    );
  }
}

class PaymentSummaryPriceSection extends StatelessWidget {
  final String housePrice;
  final String serviceFee;

  const PaymentSummaryPriceSection({
    super.key,
    required this.housePrice,
    required this.serviceFee,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReceiptDetailRow(
          label: AppConstants.housePrices,
          value: '\$$housePrice',
        ),
        SizedBox(height: 14.h),
        ReceiptDetailRow(
          label: AppConstants.habiSpaceServiceFee,
          value: '\$$serviceFee',
        ),
      ],
    );
  }
}

class RealEstateBookingSummarySection extends StatelessWidget {
  final String realEstateTitle;
  final String appointmentDate;

  const RealEstateBookingSummarySection({
    super.key,
    required this.realEstateTitle,
    required this.appointmentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReceiptDetailRow(
          label: AppConstants.realEstate,
          value: realEstateTitle,
        ),
        SizedBox(height: 14.h),
        ReceiptDetailRow(
          label: AppConstants.bookAppointment,
          value: appointmentDate,
        ),
      ],
    );
  }
}

class ReceiptDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const ReceiptDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class DownloadReceiptButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DownloadReceiptButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightCyanBtn,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConstants.downloadReceipt,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.paymentTeal,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.picture_as_pdf_outlined,
              color: AppColors.paymentTeal,
              size: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}
