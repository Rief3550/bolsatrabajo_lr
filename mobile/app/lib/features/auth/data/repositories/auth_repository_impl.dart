import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/services/auth_service.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl(this._authService, this._localStorageService);

  @override
  Future<Either<Failure, UserModel>> checkAuthStatus() async {
    try {
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
      // Simulación de login exitoso
      final user = UserModel(
        id: '123',
        username: username,
        name: 'Juan',
        lastName: 'Pérez',
        email: 'juan@example.com',
        address: 'Calle Principal 123',
        age: 30,
        profileType: 'Prestación',
        isPhysicalPerson: true,
        isNonPhysicalPerson: false,
        requestedProfessions: ['Mecánico'],
        contractionType: 'Permanente',
        rating: 4.5,
        isBlocked: false,
        isAvailable: true,
        hasAgreedToConfidentiality: true,
      );
      
      await _authService.saveUser(user);
      await _authService.saveToken('fake_token');
      await _authService.saveRefreshToken('fake_refresh_token');
      
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(
        message: 'Error during login: ${e.toString()}',
        statusCode: 401,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> register(String name, String lastName, String email, String username, String password) async {
    try {
      // Simulación de registro exitoso
      return const Right(true);
    } catch (e) {
      return Left(AuthFailure(
        message: 'Error during registration: ${e.toString()}',
        statusCode: 400,
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
      await _authService.saveUser(user);
      return const Right(true);
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
        await _authService.saveUser(updatedUser);
        return const Right(true);
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
}

