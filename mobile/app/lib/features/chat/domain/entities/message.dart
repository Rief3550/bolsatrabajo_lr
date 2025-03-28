import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
    id,
    chatId,
    senderId,
    content,
    timestamp,
    isRead,
  ];
}

