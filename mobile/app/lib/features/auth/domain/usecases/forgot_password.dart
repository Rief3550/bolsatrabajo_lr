import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';

class ForgotPassword implements UseCase<bool, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(ForgotPasswordParams params) {
    return repository.forgotPassword(params.email);
  }
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}

