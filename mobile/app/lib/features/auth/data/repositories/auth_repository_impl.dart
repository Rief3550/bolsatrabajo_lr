import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_job_marketplace/core/api/api_endpoints.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/auth_response.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/services/auth_service.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final LocalStorageService _localStorageService;
  final Dio _dio;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(
    this._authService, 
    this._localStorageService,
  ) : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ),
      _googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

  @override
  Future<Either<Failure, UserModel>> checkAuthStatus() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        return const Left(AuthFailure(
          message: 'No authenticated user found',
          statusCode: 401,
        ));
      }

      final user = await _authService.getUser();
      if (user != null) {
        return Right(user);
      } else {
        return const Left(AuthFailure(
          message: 'No authenticated user found',
          statusCode: 401,
        ));
      }
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final authResponse = AuthResponse.fromJson(response.data);
      
      await _authService.saveToken(authResponse.accessToken);
      await _authService.saveRefreshToken(authResponse.refreshToken);
      await _authService.saveUser(authResponse.user);
      
      return Right(authResponse.user);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error during login',
          statusCode: e.response?.statusCode ?? 401,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during login',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> register(String name, String lastName, String email, String username, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: jsonEncode({
          'name': name,
          'lastName': lastName,
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(AuthFailure(
          message: response.data['message'] ?? 'Error during registration',
          statusCode: response.statusCode ?? 400,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error during registration',
          statusCode: e.response?.statusCode ?? 400,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during registration',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authService.logout();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(UserModel user) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        return const Left(AuthFailure(
          message: 'No authenticated user found',
          statusCode: 401,
        ));
      }

      final response = await _dio.put(
        ApiEndpoints.updateProfile,
        data: jsonEncode(user.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        await _authService.saveUser(user);
        return const Right(true);
      } else {
        return Left(ServerFailure(
          message: response.data['message'] ?? 'Error updating profile',
          statusCode: response.statusCode ?? 400,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ServerFailure(
          message: e.response?.data['message'] ?? 'Error updating profile',
          statusCode: e.response?.statusCode ?? 400,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during profile update',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> agreeToConfidentiality() async {
    try {
      final user = await _authService.getUser();
      if (user != null) {
        final updatedUser = user.copyWith(hasAgreedToConfidentiality: true);
        return updateUserProfile(updatedUser);
      } else {
        return const Left(AuthFailure(
          message: 'No authenticated user found',
          statusCode: 401,
        ));
      }
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, UserModel>> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return const Left(AuthFailure(
          message: 'Google sign in cancelled',
          statusCode: 401,
        ));
      }
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      final response = await _dio.post(
        ApiEndpoints.googleLogin,
        data: jsonEncode({
          'token': googleAuth.idToken,
        }),
      );
      
      final authResponse = AuthResponse.fromJson(response.data);
      
      await _authService.saveToken(authResponse.accessToken);
      await _authService.saveRefreshToken(authResponse.refreshToken);
      await _authService.saveUser(authResponse.user);
      
      return Right(authResponse.user);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error during Google login',
          statusCode: e.response?.statusCode ?? 401,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during Google login',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(String token) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyEmail,
        data: jsonEncode({
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        // Actualizar el usuario local con email verificado
        final user = await _authService.getUser();
        if (user != null) {
          final updatedUser = user.copyWith(isEmailVerified: true);
          await _authService.saveUser(updatedUser);
        }
        return const Right(true);
      } else {
        return Left(AuthFailure(
          message: response.data['message'] ?? 'Error verifying email',
          statusCode: response.statusCode ?? 400,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error verifying email',
          statusCode: e.response?.statusCode ?? 400,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during email verification',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.forgotPassword,
        data: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(AuthFailure(
          message: response.data['message'] ?? 'Error sending password reset email',
          statusCode: response.statusCode ?? 400,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error sending password reset email',
          statusCode: e.response?.statusCode ?? 400,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during password reset request',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String token, String newPassword) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.resetPassword,
        data: jsonEncode({
          'token': token,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(AuthFailure(
          message: response.data['message'] ?? 'Error resetting password',
          statusCode: response.statusCode ?? 400,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(AuthFailure(
          message: e.response?.data['message'] ?? 'Error resetting password',
          statusCode: e.response?.statusCode ?? 400,
        ));
      }
      return Left(NetworkFailure(
        message: 'Network error during password reset',
        statusCode: 0,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}

