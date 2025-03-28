import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class CreateJob implements UseCase<Job, CreateJobParams> {
  final JobRepository repository;

  CreateJob(this.repository);

  @override
  Future<Either<Failure, Job>> call(CreateJobParams params) {
    return repository.createJob(params.job);
  }
}

class CreateJobParams extends Equatable {
  final Job job;

  const CreateJobParams({required this.job});

  @override
  List<Object> get props => [job];
}

