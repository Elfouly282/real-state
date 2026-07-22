import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/constant/custom_logo.dart';
import 'package:real_state/core/constant/custom_png_image.dart';
import 'package:real_state/core/constant/custom_svg_image.dart';
import 'package:real_state/core/constant/custom_textformfield.dart';
import 'package:real_state/core/constant/custom_toast.dart';
import 'package:real_state/core/funcations/app_functions.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_fonts.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/core/validator/validator_auth.dart';
import 'package:real_state/features/home/prsentations/views/home_screen.dart';
import 'package:real_state/features/main_page/presentations/views/main_page_screen.dart';
import 'package:real_state/gen/assets.gen.dart';
import 'package:real_state/features/auth/presentation/views/forget_password_screen.dart';
import 'package:real_state/features/auth/presentation/views/register_screen.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomToast.showError(state.message);
        } else if (state is LoginSuccess) {
          CustomToast.showSuccess(
            'Welcome back, ${state.authResponse.user.name}!',
          );
          AppFunctions.navigateToAndFinish(context, MainPageScreen());
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
                        'Sign In Account',
                        style: getMediumStyle(
                          fontSize: AppFonts.titleLarge,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTextformfeild(
                        labelText: 'Email',
                        controller: emailCtrl,
                        hintText: "insert your email",
                        keyboardType: TextInputType.emailAddress,
                        validator: ValidatorsAuth.email,
                      ),
                      SizedBox(height: 10),
                      CustomTextformfeild(
                        isPassword: true,
                        labelText: 'Password',
                        controller: passwordCtrl,
                        hintText: "insert your password",
                        keyboardType: TextInputType.text,
                        validator: ValidatorsAuth.password,
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            AppFunctions.navigateTo(
                              context,
                              ForgetPasswordScreen(),
                            );
                          },
                          child: Text(
                            "Forget Password",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.infoColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      CustomButton(
                        data: 'Sign In',
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
                            context.read<AuthCubit>().login(
                              email: emailCtrl.text.trim(),
                              password: passwordCtrl.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'or login with',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.darkCardColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "  Sign Up",
                              style: getRegularStyle(
                                fontSize: AppFonts.bodySmall,
                                color: AppColors.infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "By signing in, you agree to our",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.darkCardColor,
                            ),
                          ),
                          Text(
                            "Terms and Conditions",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Learn how we use your data",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.darkCardColor,
                            ),
                          ),
                          Text(
                            "Sin our Privacy Policy",
                            style: getRegularStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.infoColor,
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
