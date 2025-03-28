import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;

abstract class NotificationRepository {
  Future<Either<Failure, List<app_notification.Notification>>> getNotifications();
  Future<Either<Failure, bool>> markAsRead(String notificationId);
  Future<Either<Failure, bool>> markAllAsRead();
  Future<Either<Failure, app_notification.Notification>> addNotification(app_notification.Notification notification);
  Future<Either<Failure, bool>> deleteNotification(String notificationId);
}

