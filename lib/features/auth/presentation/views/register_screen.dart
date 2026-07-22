import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:real_state/features/home/prsentations/views/home_screen.dart';
import 'package:real_state/features/main_page/presentations/views/main_page_screen.dart';
import 'package:real_state/gen/assets.gen.dart';
import 'package:real_state/features/auth/presentation/views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppFunctions.navigateToAndFinish(context, const MainPageScreen());
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
                      SizedBox(height: 10),
                      Text(
                        'Create Account',
                        style: getMediumStyle(
                          fontSize: AppFonts.titleLarge,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTextformfeild(
                        labelText: 'Full Name',
                        controller: nameCtrl,
                        hintText: 'Enter your full name',
                        keyboardType: TextInputType.name,
                        validator: ValidatorsAuth.name,
                      ),
                      SizedBox(height: 10),
                      CustomTextformfeild(
                        labelText: 'Email',
                        controller: emailCtrl,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidatorsAuth.email,
                      ),
                      SizedBox(height: 10),
                      CustomTextformfeild(
                        labelText: 'Password',
                        controller: passwordCtrl,
                        hintText: 'Enter your password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: ValidatorsAuth.password,
                      ),
                      SizedBox(height: 10),
                      CustomTextformfeild(
                        labelText: 'Confirm Password',
                        controller: confirmPasswordCtrl,
                        hintText: 'Re-enter your password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: (value) => ValidatorsAuth.confirmPassword(
                          value,
                          passwordCtrl.text,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'or register with',
                        style: getMediumStyle(
                          fontSize: AppFonts.bodyMedium,
                          color: AppColors.darkTextSecondaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        data: 'Continue with Google',
                        borderRadius: 10,
                        color: Color(0xffEBEBEB),
                        width: double.infinity,
                        fontSize: AppFonts.bodySmall,
                        txtcolor: AppColors.darkTextSecondaryColor,
                        bordercolor: Color(0xffEBEBEB),
                        height: 45,
                        icon: CustomPngImage(path: 'assets/svg/Symbol.svg.png'),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        data: 'Continue with Apple',
                        borderRadius: 10,
                        color: AppColors.black,
                        width: double.infinity,
                        fontSize: AppFonts.bodySmall,
                        txtcolor: AppColors.white,
                        bordercolor: AppColors.black,
                        height: 51,
                        icon: Icon(Icons.apple, color: AppColors.white),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        data: 'Sign Up',
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
                            context.read<AuthCubit>().register(
                              name: nameCtrl.text,
                              email: emailCtrl.text,
                              password: passwordCtrl.text,
                              confirmPassword: confirmPasswordCtrl.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.darkCardColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppFunctions.navigateTo(context, LoginScreen());
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
