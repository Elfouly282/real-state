import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, String>> forgotPassword({required String email});

  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  });
}
