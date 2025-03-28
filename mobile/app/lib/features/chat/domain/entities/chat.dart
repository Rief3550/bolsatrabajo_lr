import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String? userImageUrl;

  const Chat({
    required this.id,
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.userImageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    userName,
    lastMessage,
    lastMessageTime,
    unreadCount,
    userImageUrl,
  ];
}

