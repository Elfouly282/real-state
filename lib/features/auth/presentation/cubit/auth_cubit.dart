import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/register_use_case.dart';
import '../../domain/use_case/forgot_password_use_case.dart';
import '../../domain/use_case/reset_password_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordUseCase,

    required this.resetPasswordUseCase,
  }) : super(const AuthInitial());

  // In-memory cache for forgot-password flow
  String? email;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    final result = await loginUseCase(email: email, password: password);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(LoginSuccess(response)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(const AuthLoading());
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(RegisterSuccess(response)),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoading());
    final result = await forgotPasswordUseCase(email: email);

    result.fold((failure) => emit(AuthError(failure.message)), (message) {
      this.email = email; // Cache email for later steps
      emit(ForgotPasswordSuccess(message));
    });
  }

  Future<void> resetPassword({
    required String password,
    required String confirmPassword,
    required String otp,
  }) async {
    final currentEmail = email;

    if (currentEmail == null) {
      emit(
        const AuthError(
          'Missing session details. Please restart forgot password flow.',
        ),
      );
      return;
    }

    emit(const AuthLoading());
    final result = await resetPasswordUseCase(
      email: currentEmail,
      otp: otp,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold((failure) => emit(AuthError(failure.message)), (message) {
      email = null;

      emit(ResetPasswordSuccess(message));
    });
  }
}
