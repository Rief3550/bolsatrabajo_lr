import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _apiClient;
  final LocalStorageService _localStorageService;

  NotificationRepositoryImpl(this._apiClient, this._localStorageService);

  @override
  Future<Either<Failure, List<app_notification.Notification>>> getNotifications() async {
    try {
      // Simulación para desarrollo
      final notifications = [
        app_notification.Notification(
          id: '1',
          userId: 'USER_123',
          type: 'request',
          content: 'Solicita presupuesto a trabajo de pintura',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
        ),
        app_notification.Notification(
          id: '2',
          userId: 'USER_12',
          type: 'request',
          content: 'Solicita presupuesto para trabajo de pintura 80mts2',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          isRead: false,
        ),
        app_notification.Notification(
          id: '3',
          userId: 'USER_234',
          type: 'request',
          content: 'Solicita cotización pintura de galpón 1200mts2',
          date: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
        ),
      ];
      
      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String notificationId) async {
    try {
      // Simulación para desarrollo
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> markAllAsRead() async {
    try {
      // Simulación para desarrollo
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, app_notification.Notification>> addNotification(app_notification.Notification notification) async {
    try {
      // Simulación para desarrollo
      return Right(notification);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(String notificationId) async {
    try {
      // Simulación para desarrollo
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}

