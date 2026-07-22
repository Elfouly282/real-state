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
import 'package:real_state/features/auth/presentation/views/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otp;
  const ResetPasswordScreen({super.key, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          CustomToast.showSuccess(state.message);
          AppFunctions.navigateToAndFinish(context, LoginScreen());
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
                        'Reset Password',
                        style: getMediumStyle(
                          fontSize: AppFonts.titleLarge,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a new strong password to secure your account.',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                          fontSize: AppFonts.bodySmall,
                          color: AppColors.darkTextSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextformfeild(
                        labelText: 'Password',
                        controller: passwordCtrl,
                        hintText: 'Enter new password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: ValidatorsAuth.password,
                      ),
                      const SizedBox(height: 10),
                      CustomTextformfeild(
                        labelText: 'Confirm Password',
                        controller: confirmPasswordCtrl,
                        hintText: 'Confirm new password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: (value) => ValidatorsAuth.confirmPassword(
                          value,
                          passwordCtrl.text,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        data: 'Reset Password',
                        borderRadius: 10,
                        color: AppColors.infoColor,
                        width: double.infinity,
                        fontSize: AppFonts.bodyMedium,
                        txtcolor: AppColors.white,
                        bordercolor: AppColors.infoColor,
                        height: 51,
                        isLoading: isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().resetPassword(
                              otp: widget.otp,
                              password: passwordCtrl.text,
                              confirmPassword: confirmPasswordCtrl.text,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
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
