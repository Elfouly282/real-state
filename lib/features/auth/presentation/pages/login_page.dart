import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/custom_button.dart';
import '../../../../core/constant/custom_logo.dart';
import '../../../../core/constant/custom_toast.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../app/admin_shell.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          CustomToast.showError(state.message);
        }
        if (state is AuthSuccess) {
          CustomToast.showSuccess('مرحباً ${state.user.name}');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AdminShell()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),

                    // Logo
                    CustomLogo(width: 100.w, height: 100.h),
                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      'تسجيل الدخول',
                      style: getBoldStyle(
                        fontSize: AppFonts.headlineSmall,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'أهلاً بك، سجّل دخولك للمتابعة',
                      style: getRegularStyle(
                        fontSize: AppFonts.bodyMedium,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Email
                    AuthTextField(
                      controller: _emailCtrl,
                      label: 'البريد الإلكتروني',
                      hint: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'أدخل البريد الإلكتروني';
                        if (!v.contains('@')) return 'بريد إلكتروني غير صالح';
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Password
                    AuthTextField(
                      controller: _passwordCtrl,
                      label: 'كلمة المرور',
                      hint: '••••••••',
                      isPassword: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'أدخل كلمة المرور';
                        if (v.length < 6) return 'كلمة المرور قصيرة جداً';
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),

                    // Login button
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          data: 'تسجيل الدخول',
                          isLoading: state is AuthLoading,
                          onTap: _submit,
                        );
                      },
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
