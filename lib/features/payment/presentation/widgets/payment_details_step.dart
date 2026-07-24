import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';
import 'package:real_state/features/payment/presentation/widgets/add_on_section.dart';
import 'package:real_state/features/payment/presentation/widgets/insurance_section.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_card_details_section.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_stepper_header.dart';
import 'package:real_state/features/payment/presentation/widgets/price_details_section.dart';
import 'package:real_state/features/payment/presentation/widgets/property_summary_card.dart';
import 'package:real_state/features/payment/presentation/widgets/resident_data_section.dart';

class PaymentDetailsStepBody extends StatelessWidget {
  final PropertySummaryEntity? propertySummary;
  final String name;
  final String phone;
  final String email;

  const PaymentDetailsStepBody({
    super.key,
    required this.propertySummary,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final summary =
        propertySummary ??
        const PropertySummaryEntity(
          id: 1,
          title: 'Sunnyslade House',
          address: 'Beverly Hills, CA',
          imageUrl:
              'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=200',
          price: '120.000',
          rate: 4.9,
          description: '',
          reviews: '10',
          appointmentDate: '12 Sept 2025 - 09.00',
        );

    return Column(
      children: [
        const PaymentStepperHeader(currentStep: 1),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            children: [
              SizedBox(height: 20.h),
              PropertySummaryCard(propertySummary: summary),
              Divider(height: 40.h),
              ResidentDataSection(
                name: name,
                phone: phone,
                email: email,
                noticeText: AppConstants.residentNoticeText,
              ),
              Divider(height: 40.h),
              const AddOnSection(),
              Divider(height: 40.h),
              const InsuranceSection(),
              Divider(height: 40.h),
              // const PaymentMethodSection(),
              Divider(height: 40.h),
              PriceDetailsSection(
                housePrice: summary.price,
                serviceFee: '250',
                totalPrice: '120.250',
              ),
              Divider(height: 40.h),
              const PaymentCardDetailsSection(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}
