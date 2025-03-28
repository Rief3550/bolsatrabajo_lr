import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/models/user_model.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfile implements UseCase<bool, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateProfileParams params) {
    return repository.updateProfile(params.user);
  }
}

class UpdateProfileParams extends Equatable {
  final UserModel user;

  const UpdateProfileParams({required this.user});

  @override
  List<Object> get props => [user];
}

