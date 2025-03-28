import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/models/job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getJobs();
  Future<Either<Failure, Job>> getJobById(String id);
  Future<Either<Failure, Job>> createJob(Job job);
  Future<Either<Failure, Job>> updateJob(Job job);
  Future<Either<Failure, bool>> deleteJob(String id);
  Future<Either<Failure, List<Job>>> getJobsByUserId(String userId);
}

