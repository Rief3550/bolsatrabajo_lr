import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmail implements UseCase<bool, VerifyEmailParams> {
  final AuthRepository repository;

  VerifyEmail(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyEmailParams params) {
    return repository.verifyEmail(params.token);
  }
}

class VerifyEmailParams extends Equatable {
  final String token;

  const VerifyEmailParams({required this.token});

  @override
  List<Object> get props => [token];
}

