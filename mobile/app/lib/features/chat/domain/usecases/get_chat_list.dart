import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/chat.dart';
import 'package:flutter_job_marketplace/features/chat/domain/repositories/chat_repository.dart';

class GetChatList implements UseCase<List<Chat>, NoParams> {
  final ChatRepository repository;

  GetChatList(this.repository);

  @override
  Future<Either<Failure, List<Chat>>> call(NoParams params) {
    return repository.getChatList();
  }
}

