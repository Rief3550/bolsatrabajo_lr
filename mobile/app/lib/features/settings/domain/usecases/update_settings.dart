import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/settings/domain/entities/settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/repositories/settings_repository.dart';

class UpdateSettings implements UseCase<bool, UpdateSettingsParams> {
  final SettingsRepository repository;

  UpdateSettings(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateSettingsParams params) {
    return repository.updateSettings(params.settings);
  }
}

class UpdateSettingsParams extends Equatable {
  final Settings settings;

  const UpdateSettingsParams({required this.settings});

  @override
  List<Object> get props => [settings];
}

