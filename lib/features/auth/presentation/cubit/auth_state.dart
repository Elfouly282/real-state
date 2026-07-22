import '../../domain/entity/user_entity.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoginSuccess extends AuthState {
  final AuthResponse authResponse;
  const LoginSuccess(this.authResponse);
}

class RegisterSuccess extends AuthState {
  final AuthResponse authResponse;
  const RegisterSuccess(this.authResponse);
}

class ForgotPasswordSuccess extends AuthState {
  final String message;
  const ForgotPasswordSuccess(this.message);
}

class VerifyCodeSuccess extends AuthState {
  final String message;
  const VerifyCodeSuccess(this.message);
}

class ResetPasswordSuccess extends AuthState {
  final String message;
  const ResetPasswordSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
