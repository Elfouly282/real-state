import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/app_constants.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_cubit.dart';
import 'package:real_state/features/payment/presentation/view_model/payment_states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewStepBody extends StatefulWidget {
  final int propertyId;

  const PaymentWebViewStepBody({super.key, this.propertyId = 1});

  @override
  State<PaymentWebViewStepBody> createState() => _PaymentWebViewStepBodyState();
}

class _PaymentWebViewStepBodyState extends State<PaymentWebViewStepBody> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().createOrder(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentStates>(
      buildWhen: (previous, current) {
        return current is CreateOrderLoadingState ||
            current is CreateOrderSuccessState ||
            current is CreateOrderErrorState;
      },
      builder: (context, state) {
        if (state is CreateOrderLoadingState) {
          return const PaymentWebViewLoadingWidget();
        } else if (state is CreateOrderErrorState) {
          return PaymentWebViewErrorWidget(
            errorMessage: state.message,
            onRetry: () {
              context.read<PaymentCubit>().createOrder(widget.propertyId);
            },
          );
        } else if (state is CreateOrderSuccessState) {
          debugPrint(state.paymentUrl);
          return PaymentWebViewContent(paymentUrl: state.paymentUrl);
        } else {
          return const PaymentWebViewLoadingWidget();
        }
      },
    );
  }
}

class PaymentWebViewLoadingWidget extends StatelessWidget {
  const PaymentWebViewLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.paymentTeal,
            strokeWidth: 3.w,
          ),
          SizedBox(height: 20.h),
          Text(
            AppConstants.preparingPaymentCheckout,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentWebViewErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const PaymentWebViewErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent, size: 56.r),
              SizedBox(height: 16.h),
              Text(
                AppConstants.paymentOrderFailed,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: AppColors.white),
                label: Text(
                  AppConstants.tryAgain,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.paymentTeal,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentWebViewContent extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewContent({super.key, required this.paymentUrl});

  @override
  State<PaymentWebViewContent> createState() => _PaymentWebViewContentState();
}

class _PaymentWebViewContentState extends State<PaymentWebViewContent> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('🔗 NAVIGATING TO: ${request.url}');

            final url = request.url.toLowerCase();

            if (url.contains('paid=1') || url.contains('success')) {
              debugPrint('🎉 PAYMENT SUCCESS DETECTED!');
              context.read<PaymentCubit>().stepChanged(3);
              return NavigationDecision.prevent;
            }

            if (url.contains('paid=0') || url.contains('cancel')) {
              _handlePaymentCancel();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handlePaymentCancel() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Payment was canceled.')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.paymentTeal),
          ),
      ],
    );
  }
}
