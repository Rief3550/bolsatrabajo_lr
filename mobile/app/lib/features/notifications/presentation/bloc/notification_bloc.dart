import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/get_notifications.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/mark_all_as_read.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/usecases/mark_as_read.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  final MarkAsRead markAsRead;
  final MarkAllAsRead markAllAsRead;

  NotificationBloc({
    required this.getNotifications,
    required this.markAsRead,
    required this.markAllAsRead,
  }) : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_onGetNotifications);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
  }

  Future<void> _onGetNotifications(
    GetNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    
    final result = await getNotifications(NoParams());
    
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationsLoaded(notifications)),
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      emit(NotificationLoading());
      
      final result = await markAsRead(MarkAsReadParams(notificationId: event.notificationId));
      
      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (success) {
          final updatedNotifications = currentState.notifications.map((notification) {
            if (notification.id == event.notificationId) {
              return app_notification.Notification(
                id: notification.id,
                userId: notification.userId,
                type: notification.type,
                content: notification.content,
                date: notification.date,
                isRead: true,
              );
            }
            return notification;
          }).toList();
          
          emit(NotificationsLoaded(updatedNotifications));
        },
      );
    }
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotificationsLoaded) {
      emit(NotificationLoading());
      
      final result = await markAllAsRead(NoParams());
      
      result.fold(
        (failure) => emit(NotificationError(failure.message)),
        (success) {
          final updatedNotifications = currentState.notifications.map((notification) {
            return app_notification.Notification(
              id: notification.id,
              userId: notification.userId,
              type: notification.type,
              content: notification.content,
              date: notification.date,
              isRead: true,
            );
          }).toList();
          
          emit(NotificationsLoaded(updatedNotifications));
        },
      );
    }
  }
}

