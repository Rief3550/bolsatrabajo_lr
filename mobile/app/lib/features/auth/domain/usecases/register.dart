import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/auth/domain/repositories/auth_repository.dart';

class Register implements UseCase<bool, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) {
    return repository.register(
      params.name,
      params.lastName,
      params.email,
      params.username,
      params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String username;
  final String password;

  const RegisterParams({
    required this.name,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [name, lastName, email, username, password];
}

