import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class UpdateJob implements UseCase<Job, UpdateJobParams> {
  final JobRepository repository;

  UpdateJob(this.repository);

  @override
  Future<Either<Failure, Job>> call(UpdateJobParams params) {
    return repository.updateJob(params.job);
  }
}

class UpdateJobParams extends Equatable {
  final Job job;

  const UpdateJobParams({required this.job});

  @override
  List<Object> get props => [job];
}

