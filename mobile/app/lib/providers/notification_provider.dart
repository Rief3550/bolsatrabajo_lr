import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;

class NotificationProvider extends ChangeNotifier {
  List<app_notification.Notification> _notifications = [];
  bool _isLoading = false;

  List<app_notification.Notification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((notification) => !notification.isRead).length;

  NotificationProvider() {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would fetch notifications from a backend
      // For now, we'll create some mock notifications
      await Future.delayed(const Duration(seconds: 1));

      _notifications = [
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
        app_notification.Notification(
          id: '4',
          userId: 'USER_77',
          type: 'request',
          content: 'Solicita presupuesto pintura cocina 52mts2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
        ),
      ];
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final index = _notifications.indexWhere((notification) => notification.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        _notifications[index] = app_notification.Notification(
          id: notification.id,
          userId: notification.userId,
          type: notification.type,
          content: notification.content,
          date: notification.date,
          isRead: true,
        );
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> markAllAsRead() async {
    try {
      _notifications = _notifications.map((notification) => app_notification.Notification(
        id: notification.id,
        userId: notification.userId,
        type: notification.type,
        content: notification.content,
        date: notification.date,
        isRead: true,
      )).toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addNotification(app_notification.Notification notification) async {
    try {
      _notifications.insert(0, notification);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      _notifications.removeWhere((notification) => notification.id == notificationId);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}

