import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/message.dart';
import 'package:flutter_job_marketplace/features/chat/domain/repositories/chat_repository.dart';

class GetMessages implements UseCase<List<Message>, GetMessagesParams> {
  final ChatRepository repository;

  GetMessages(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(GetMessagesParams params) {
    return repository.getMessages(params.chatId);
  }
}

class GetMessagesParams extends Equatable {
  final String chatId;

  const GetMessagesParams({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

