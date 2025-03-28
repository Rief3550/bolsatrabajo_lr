import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/message.dart';
import 'package:flutter_job_marketplace/features/chat/domain/repositories/chat_repository.dart';

class SendMessage implements UseCase<Message, SendMessageParams> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) {
    return repository.sendMessage(params.chatId, params.content);
  }
}

class SendMessageParams extends Equatable {
  final String chatId;
  final String content;

  const SendMessageParams({
    required this.chatId,
    required this.content,
  });

  @override
  List<Object> get props => [chatId, content];
}

