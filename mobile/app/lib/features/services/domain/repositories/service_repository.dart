import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/models/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Service>>> getServices();
  Future<Either<Failure, Service>> getServiceById(String id);
  Future<Either<Failure, Service>> createService(Service service);
  Future<Either<Failure, Service>> updateService(Service service);
  Future<Either<Failure, bool>> deleteService(String id);
}

