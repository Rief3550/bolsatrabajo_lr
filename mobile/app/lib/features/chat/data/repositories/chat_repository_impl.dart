import 'package:dartz/dartz.dart';
import 'package:flutter_job_marketplace/core/api/api_client.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/local_storage/local_storage_service.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/chat.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/message.dart';
import 'package:flutter_job_marketplace/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ApiClient _apiClient;
  final LocalStorageService _localStorageService;

  ChatRepositoryImpl(this._apiClient, this._localStorageService);

  @override
  Future<Either<Failure, List<Chat>>> getChatList() async {
    try {
      // Simulación para desarrollo
      final chats = [
        Chat(
          id: '1',
          userId: 'user1',
          userName: 'Juan Pérez',
          lastMessage: 'Hola, ¿cómo estás?',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
          unreadCount: 2,
          userImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        ),
        Chat(
          id: '2',
          userId: 'user2',
          userName: 'María López',
          lastMessage: 'Necesito un presupuesto para pintar mi casa',
          lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
          unreadCount: 0,
          userImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        ),
      ];
      
      return Right(chats);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String chatId) async {
    try {
      // Simulación para desarrollo
      final messages = [
        Message(
          id: '1',
          chatId: chatId,
          senderId: 'user1',
          content: 'Hola, ¿cómo estás?',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
        Message(
          id: '2',
          chatId: chatId,
          senderId: 'currentUser',
          content: 'Bien, gracias. ¿Y tú?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
          isRead: true,
        ),
      ];
      
      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(String chatId, String content) async {
    try {
      // Simulación para desarrollo
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        chatId: chatId,
        senderId: 'currentUser',
        content: content,
        timestamp: DateTime.now(),
        isRead: false,
      );
      
      return Right(message);
    } catch (e) {
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String chatId) async {
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

