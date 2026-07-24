import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/features/payment/domain/entity/property_summary_entity.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_cubit.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_states.dart';
import 'package:real_state/features/payment/presentation/widgets/booking_app_bar.dart';
import 'package:real_state/features/payment/presentation/widgets/booking_bottom_bar.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_details_step.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_method_selection_step.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_success_step.dart';
import 'package:real_state/features/payment/presentation/widgets/payment_web_view_step.dart';
import 'package:real_state/features/payment/presentation/widgets/review_data_step.dart';

class PaymentView extends StatefulWidget {
  final PropertySummaryEntity propertySummary;
  final String name;
  final String phone;
  final String email;

  const PaymentView({
    super.key,
    required this.propertySummary,
    required this.name,
    required this.phone,
    required this.email,
    // required this.currentStep,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookingAppBar(
        currentStep: currentStep == 0
            ? "Request to Book"
            : currentStep == 1
            ? "Booking Details"
            : currentStep == 2
            ? "Choose Payment"
            : currentStep == 3
            ? "Booking Details"
            : currentStep == 4
            ? "Booking Receipt"
            : AppConstants.done,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<PaymentCubit, PaymentStates>(
        builder: (context, state) {
          switch (state.stepNumber) {
            case 0:
              return ReviewDataStepBody(
                propertySummary: widget.propertySummary,
              );
            case 1:
              return PaymentDetailsStepBody(
                propertySummary: widget.propertySummary,
                name: widget.name,
                phone: widget.phone,
                email: widget.email,
              );
            case 2:
              return const PaymentMethodSelectionStepBody();
            case 3:
              return PaymentWebViewStepBody(
                propertyId: widget.propertySummary.id,
              );
            case 4:
              return PaymentSuccessStepBody(
                propertySummary: widget.propertySummary,
                name: widget.name,
              );
            default:
              return const Scaffold(body: Center(child: Text('Screen 4')));
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<PaymentCubit, PaymentStates>(
        builder: (context, state) {
          return BookingBottomBar(
            title: state.stepNumber == 0
                ? AppConstants.nextReviewData
                : state.stepNumber == 1
                ? AppConstants.nextPaymentDetails
                : state.stepNumber == 2
                ? "Select: Payment Method"
                : state.stepNumber == 3
                ? AppConstants.finishPayment
                : state.stepNumber == 4
                ? AppConstants.returnToHome
                : AppConstants.done,
            isLoading: state is CreateOrderLoadingState,
            onPressed: () {
              context.read<PaymentCubit>().stepChanged(state.stepNumber);
              if (state.stepNumber == 4) {
                Navigator.pop(context);
              }
              setState(() {
                currentStep = state.stepNumber;
              });
            },
          );
        },
      ),
    );
  }
}
