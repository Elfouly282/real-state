import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/constant/custom_png_image.dart';
import 'package:real_state/core/constant/custom_textformfield.dart';
import 'package:real_state/core/constant/custom_toast.dart';
import 'package:real_state/core/funcations/app_functions.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_fonts.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/core/validator/validator_auth.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_state.dart';
import 'package:real_state/gen/assets.gen.dart';
import 'package:real_state/features/auth/presentation/views/verification_code_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          print('bbbbbbbbbbb${state.message}');
          AppFunctions.navigateTo(context, VerificationCodeScreen());
        } else if (state is AuthError) {
          CustomToast.showError(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      CustomPngImage(
                        path: Assets.png.logoTeal.path,
                        height: 51,
                        width: 171,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Forget Password',
                        style: getMediumStyle(
                          fontSize: AppFonts.titleLarge,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your registered email address and we will send\nyou a verification code to reset your password.',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          fontSize: AppFonts.bodySmall,
                          color: AppColors.darkTextSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextformfeild(
                        labelText: 'Email',
                        controller: emailCtrl,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidatorsAuth.email,
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        data: 'Send Verification Code',
                        borderRadius: 10,
                        color: AppColors.infoColor,
                        width: double.infinity,
                        fontSize: AppFonts.bodyMedium,
                        txtcolor: AppColors.white,
                        bordercolor: AppColors.infoColor,
                        isLoading: isLoading,
                        height: 51,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().forgotPassword(
                              email: emailCtrl.text.trim(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Remember your password? ',
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.darkCardColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign In',
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
      },
    );
  }
}
