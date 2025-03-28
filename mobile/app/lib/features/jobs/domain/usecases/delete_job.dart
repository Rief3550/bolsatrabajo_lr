import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/repositories/job_repository.dart';

class DeleteJob implements UseCase<bool, DeleteJobParams> {
  final JobRepository repository;

  DeleteJob(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteJobParams params) {
    return repository.deleteJob(params.id);
  }
}

class DeleteJobParams extends Equatable {
  final String id;

  const DeleteJobParams({required this.id});

  @override
  List<Object> get props => [id];
}

