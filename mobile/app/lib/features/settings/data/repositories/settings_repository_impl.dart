import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/settings/domain/entities/settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocalStorageService _localStorageService;

  SettingsRepositoryImpl(this._localStorageService);

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    try {
      final isDarkMode = await _localStorageService.get<bool>('isDarkMode') ?? false;
      final enableNotifications = await _localStorageService.get<bool>('enableNotifications') ?? true;
      final language = await _localStorageService.get<String>('language') ?? 'es';
      final enableLocationServices = await _localStorageService.get<bool>('enableLocationServices') ?? true;

      final settings = Settings(
        isDarkMode: isDarkMode,
        enableNotifications: enableNotifications,
        language: language,
        enableLocationServices: enableLocationServices,
      );

      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateSettings(Settings settings) async {
    try {
      await _localStorageService.save('isDarkMode', settings.isDarkMode);
      await _localStorageService.save('enableNotifications', settings.enableNotifications);
      await _localStorageService.save('language', settings.language);
      await _localStorageService.save('enableLocationServices', settings.enableLocationServices);

      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}

