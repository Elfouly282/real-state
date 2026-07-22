import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/custom_toast.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../app/admin_shell.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/index.dart';

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
        if (state is AuthFailure) CustomToast.showError(state.message);
        if (state is AuthSuccess) {
          CustomToast.showSuccess('Welcome, ${state.user.name}');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => AdminShell(admin: state.user)),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surfaceBg,
        body: Stack(
          children: [
            Positioned(
              top: -100,
              right: -80,
              child: DecorCircle(
                size: 320,
                color: AppColors.primaryColor.withValues(alpha: 0.08),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -60,
              child: DecorCircle(
                size: 280,
                color: AppColors.secondaryColor.withValues(alpha: 0.06),
              ),
            ),
            Positioned(
              top: 80,
              left: -40,
              child: DecorCircle(
                size: 160,
                color: AppColors.primaryColor.withValues(alpha: 0.05),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 44),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                          blurRadius: 40,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LogoWithShadow(size: 84),
                          const SizedBox(height: 20),
                          Text(
                            'Real State',
                            style: getBoldStyle(
                              fontSize: AppFonts.headlineSmall,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Admin Dashboard',
                            style: getMediumStyle(
                              fontSize: AppFonts.bodySmall,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Row(children: [
                            Expanded(
                              child: Container(height: 1, color: AppColors.greychip),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Sign In',
                                style: getMediumStyle(
                                  fontSize: AppFonts.bodySmall,
                                  color: AppColors.textSecondaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(height: 1, color: AppColors.greychip),
                            ),
                          ]),
                          const SizedBox(height: 28),
                          FieldLabel(label: 'Email Address', icon: AppIcons.email),
                          const SizedBox(height: 6),
                          AuthTextField(
                            controller: _emailCtrl,
                            label: '',
                            hint: 'admin@example.com',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              AppIcons.email,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Enter your email';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v)) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          FieldLabel(label: 'Password', icon: AppIcons.password),
                          const SizedBox(height: 6),
                          AuthTextField(
                            controller: _passwordCtrl,
                            label: '',
                            hint: '••••••••',
                            isPassword: true,
                            prefixIcon: Icon(
                              AppIcons.password,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Enter your password';
                              if (v.length < 6) return 'Password too short';
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;
                              return SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: AppColors.white,
                                    elevation: 0,
                                    shadowColor: AppColors.primaryColor
                                        .withValues(alpha: 0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: AppColors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Sign In',
                                              style: getBoldStyle(
                                                fontSize: AppFonts.bodyLarge,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              AppIcons.nextArrow,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Real State Admin © 2026',
                            style: getRegularStyle(
                              fontSize: AppFonts.labelSmall,
                              color: AppColors.textLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
