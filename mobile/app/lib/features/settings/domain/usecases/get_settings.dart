import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/settings/domain/entities/settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/repositories/settings_repository.dart';

class GetSettings implements UseCase<Settings, NoParams> {
  final SettingsRepository repository;

  GetSettings(this.repository);

  @override
  Future<Either<Failure, Settings>> call(NoParams params) {
    return repository.getSettings();
  }
}

