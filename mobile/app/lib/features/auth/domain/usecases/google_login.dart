import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';

class GoogleLogin implements UseCase<UserModel, NoParams> {
  final AuthRepository repository;

  GoogleLogin(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) {
    return repository.googleLogin();
  }
}

