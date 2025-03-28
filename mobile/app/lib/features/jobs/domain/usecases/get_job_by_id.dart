import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class GetJobById implements UseCase<Job, JobParams> {
  final JobRepository repository;

  GetJobById(this.repository);

  @override
  Future<Either<Failure, Job>> call(JobParams params) {
    return repository.getJobById(params.id);
  }
}

class JobParams extends Equatable {
  final String id;

  const JobParams({required this.id});

  @override
  List<Object> get props => [id];
}

