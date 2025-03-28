import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;

class GetNotifications implements UseCase<List<app_notification.Notification>, NoParams> {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Either<Failure, List<app_notification.Notification>>> call(NoParams params) {
    return repository.getNotifications();
  }
}

