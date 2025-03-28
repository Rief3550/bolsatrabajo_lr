import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;
  final LocalStorageService _localStorageService;

  ProfileRepositoryImpl(this._apiClient, this._localStorageService);

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      // Simulación para desarrollo
      final user = UserModel(
        id: '123',
        username: 'user123',
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
        profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      );
      
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile(UserModel user) async {
    try {
      // Simulación para desarrollo
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> uploadProfileImage(String imagePath) async {
    try {
      // Simulación para desarrollo
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}

