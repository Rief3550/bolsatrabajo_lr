import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/chat.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getChatList();
  Future<Either<Failure, List<Message>>> getMessages(String chatId);
  Future<Either<Failure, Message>> sendMessage(String chatId, String content);
  Future<Either<Failure, bool>> markAsRead(String chatId);
}

