import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class GetJobs implements UseCase<List<Job>, NoParams> {
  final JobRepository repository;

  GetJobs(this.repository);

  @override
  Future<Either<Failure, List<Job>>> call(NoParams params) {
    return repository.getJobs();
  }
}

