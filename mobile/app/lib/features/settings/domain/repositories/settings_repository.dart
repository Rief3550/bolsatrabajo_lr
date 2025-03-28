import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> getSettings();
  Future<Either<Failure, bool>> updateSettings(Settings settings);
}

