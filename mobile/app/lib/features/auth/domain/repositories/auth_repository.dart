import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> checkAuthStatus();
  Future<Either<Failure, UserModel>> login(String username, String password);
  Future<Either<Failure, bool>> register(String name, String lastName, String email, String username, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> updateUserProfile(UserModel user);
  Future<Either<Failure, bool>> agreeToConfidentiality();
  Future<Either<Failure, UserModel>> googleLogin();
  Future<Either<Failure, bool>> verifyEmail(String token);
  Future<Either<Failure, bool>> forgotPassword(String email);
  Future<Either<Failure, bool>> resetPassword(String token, String newPassword);
}

