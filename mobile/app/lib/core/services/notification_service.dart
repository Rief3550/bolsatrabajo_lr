import 'package:flutter/material.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
}

class NotificationServiceImpl implements NotificationService {
  @override
  Future<void> initialize() async {
    // En una implementación real, inicializaríamos flutter_local_notifications
    debugPrint('Notification service initialized');
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('Show notification: $title - $body');
  }

  @override
  Future<void> cancelNotification(int id) async {
    debugPrint('Cancel notification: $id');
  }

  @override
  Future<void> cancelAllNotifications() async {
    debugPrint('Cancel all notifications');
  }
}

