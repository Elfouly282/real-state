import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_card_details_section.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_stepper_header.dart';

class PaymentMethodSelectionStepBody extends StatefulWidget {
  const PaymentMethodSelectionStepBody({super.key});

  @override
  State<PaymentMethodSelectionStepBody> createState() =>
      _PaymentMethodSelectionStepBodyState();
}

class _PaymentMethodSelectionStepBodyState
    extends State<PaymentMethodSelectionStepBody> {
  int selectedOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      children: [
        const PaymentStepperHeader(currentStep: 2),
        SizedBox(height: 24.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              PaymentOptionTile(
                title: AppConstants.creditCardDebit,
                isSelected: selectedOptionIndex == 0,
                onTap: () => setState(() => selectedOptionIndex = 0),
                brandLogos: const CreditCardLogosWidget(),
              ),
              Divider(height: 1.h, color: Colors.grey.shade200),
              PaymentOptionTile(
                title: AppConstants.mobileBanking,
                isSelected: selectedOptionIndex == 1,
                onTap: () => setState(() => selectedOptionIndex = 1),
                brandLogos: const MobileBankingLogosWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget brandLogos;

  const PaymentOptionTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.brandLogos,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            brandLogos,
            SizedBox(width: 14.w),
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.paymentTeal
                      : Colors.grey.shade400,
                  width: isSelected ? 6.5.w : 1.5.w,
                ),
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardLogosWidget extends StatelessWidget {
  const CreditCardLogosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VisaBadgeWidget(),
        SizedBox(width: 8.w),
        const MastercardLogoWidget(),
      ],
    );
  }
}

class MastercardLogoWidget extends StatelessWidget {
  const MastercardLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26.w,
      height: 16.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 16.w,
              height: 16.h,
              decoration: const BoxDecoration(
                color: AppColors.mastercardRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColors.mastercardOrange.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileBankingLogosWidget extends StatelessWidget {
  const MobileBankingLogosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BankOfAmericaLogoWidget(),
        SizedBox(width: 8.w),
        const HsbcLogoWidget(),
        SizedBox(width: 8.w),
        const GreenBankLogoWidget(),
      ],
    );
  }
}

class BankOfAmericaLogoWidget extends StatelessWidget {
  const BankOfAmericaLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 14.h,
      decoration: BoxDecoration(
        color: AppColors.bankOfAmericaBlue,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Center(
        child: Container(
          width: 12.w,
          height: 3.h,
          color: AppColors.bankOfAmericaRed,
        ),
      ),
    );
  }
}

class HsbcLogoWidget extends StatelessWidget {
  const HsbcLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 14.h,
      decoration: BoxDecoration(
        color: AppColors.hsbcRed,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Center(
        child: Container(
          width: 8.w,
          height: 8.h,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class GreenBankLogoWidget extends StatelessWidget {
  const GreenBankLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 16.h,
      decoration: const BoxDecoration(
        color: AppColors.greenBankColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.account_balance, size: 10.r, color: AppColors.white),
      ),
    );
  }
}
