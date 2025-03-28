import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/notifications/domain/repositories/notification_repository.dart';

class MarkAsRead implements UseCase<bool, MarkAsReadParams> {
  final NotificationRepository repository;

  MarkAsRead(this.repository);

  @override
  Future<Either<Failure, bool>> call(MarkAsReadParams params) {
    return repository.markAsRead(params.notificationId);
  }
}

class MarkAsReadParams extends Equatable {
  final String notificationId;

  const MarkAsReadParams({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}

