import 'package:flutter/material.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/constant/custom_png_image.dart';
import 'package:real_state/core/constant/pin_code_fields.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_fonts.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/gen/assets.gen.dart';
import 'package:real_state/features/auth/presentation/views/reset_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _pinCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomPngImage(
                    path: Assets.png.logoTeal.path,
                    height: 51,
                    width: 171,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Verification Code',
                    style: getMediumStyle(
                      fontSize: AppFonts.titleLarge,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the 4-digit verification code sent to your\nemail address to verify your account.',
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      fontSize: AppFonts.bodySmall,
                      color: AppColors.darkTextSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  PinCodeFields(
                    length: 6,
                    onChanged: (value) {
                      _pinCode = value;
                    },
                    onCompleted: (value) {
                      _pinCode = value;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    data: 'Verify Code',
                    borderRadius: 10,
                    color: AppColors.infoColor,
                    width: double.infinity,
                    fontSize: AppFonts.bodyMedium,
                    txtcolor: AppColors.white,
                    bordercolor: AppColors.infoColor,
                    height: 51,
                    onTap: () {
                      if (_pinCode.length == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ResetPasswordScreen(otp: _pinCode),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: getRegularStyle(
                          fontSize: AppFonts.bodySmall,
                          color: AppColors.darkCardColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // TODO: Resend verification code
                        },
                        child: Text(
                          'Resend',
                          style: getRegularStyle(
                            fontSize: AppFonts.bodySmall,
                            color: AppColors.infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
