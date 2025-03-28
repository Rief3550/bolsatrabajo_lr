import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/services/domain/repositories/service_repository.dart';
import 'package:flutter_job_marketplace/models/service.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ApiClient _apiClient;
  final LocalStorageService _localStorageService;

  ServiceRepositoryImpl(this._apiClient, this._localStorageService);

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      // Simulación para desarrollo
      final services = [
        Service(
          id: '1',
          name: 'Mecánico',
          experience: '5 años',
          development: 'Especialista en motores',
          rubroId: 'rubro1',
          rating: 4.5,
          isAvailable: true,
          matchesCount: 12,
          jobsCount: 2,
        ),
        Service(
          id: '2',
          name: 'Pintor',
          experience: '3 años',
          development: 'Interiores y exteriores',
          rubroId: 'rubro2',
          rating: 4.2,
          isAvailable: true,
          matchesCount: 8,
          jobsCount: 4,
        ),
      ];
      
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Service>> getServiceById(String id) async {
    try {
      // Simulación para desarrollo
      final service = Service(
        id: id,
        name: 'Mecánico',
        experience: '5 años',
        development: 'Especialista en motores',
        rubroId: 'rubro1',
        rating: 4.5,
        isAvailable: true,
        matchesCount: 12,
        jobsCount: 2,
      );
      
      return Right(service);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Service>> createService(Service service) async {
    try {
      // Simulación para desarrollo
      final newService = Service(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: service.name,
        experience: service.experience,
        development: service.development,
        rubroId: service.rubroId,
        rating: service.rating,
        isAvailable: service.isAvailable,
        matchesCount: 0,
        jobsCount: 0,
      );
      
      return Right(newService);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Service>> updateService(Service service) async {
    try {
      // Simulación para desarrollo
      return Right(service);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteService(String id) async {
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

