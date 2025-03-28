import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class JobRepositoryImpl implements JobRepository {
  final ApiClient _apiClient;
  final LocalStorageService _localStorageService;

  JobRepositoryImpl(this._apiClient, this._localStorageService);

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    try {
      // Simulación de datos para desarrollo
      final jobs = [
        Job(
          id: '1',
          userId: 'user1',
          name: 'Pintura de interior',
          details: 'Pintura de interior de casa, incluye paredes y techo',
          description: 'Se requiere preparación de superficies y aplicación de dos manos de pintura',
          requirements: 'Materiales incluidos, herramientas propias',
          price: 1000,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '5 días',
          isPeriodic: false,
        ),
        Job(
          id: '2',
          userId: 'user2',
          name: 'Reparación de motor',
          details: 'Reparación de motor diésel 2.0',
          description: 'Diagnóstico y reparación de motor con problemas de arranque',
          requirements: 'Repuestos no incluidos',
          price: 1200,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '3 días',
          isPeriodic: false,
        ),
      ];
      
      return Right(jobs);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Job>> getJobById(String id) async {
    try {
      // Simulación para desarrollo
      final job = Job(
        id: id,
        userId: 'user1',
        name: 'Pintura de interior',
        details: 'Pintura de interior de casa, incluye paredes y techo',
        description: 'Se requiere preparación de superficies y aplicación de dos manos de pintura',
        requirements: 'Materiales incluidos, herramientas propias',
        price: 1000,
        type: 'Servicio',
        contract: 'Por proyecto',
        time: '5 días',
        isPeriodic: false,
      );
      
      return Right(job);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Job>> createJob(Job job) async {
    try {
      // Simulación para desarrollo
      final newJob = Job(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: job.userId,
        name: job.name,
        details: job.details,
        description: job.description,
        requirements: job.requirements,
        price: job.price,
        type: job.type,
        contract: job.contract,
        time: job.time,
        isPeriodic: job.isPeriodic,
      );
      
      return Right(newJob);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Job>> updateJob(Job job) async {
    try {
      // Simulación para desarrollo
      return Right(job);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteJob(String id) async {
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
  Future<Either<Failure, List<Job>>> getJobsByUserId(String userId) async {
    try {
      // Simulación para desarrollo
      final jobs = [
        Job(
          id: '1',
          userId: userId,
          name: 'Pintura de interior',
          details: 'Pintura de interior de casa, incluye paredes y techo',
          description: 'Se requiere preparación de superficies y aplicación de dos manos de pintura',
          requirements: 'Materiales incluidos, herramientas propias',
          price: 1000,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '5 días',
          isPeriodic: false,
        ),
      ];
      
      return Right(jobs);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}

