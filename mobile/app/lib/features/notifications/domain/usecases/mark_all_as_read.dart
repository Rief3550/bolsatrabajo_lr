import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/repositories/notification_repository.dart';

class MarkAllAsRead implements UseCase<bool, NoParams> {
  final NotificationRepository repository;

  MarkAllAsRead(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.markAllAsRead();
  }
}

