import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/chat.dart';
import 'package:flutter_job_marketplace/features/chat/domain/entities/message.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/get_chat_list.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/get_messages.dart';
import 'package:flutter_job_marketplace/features/chat/domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatList getChatList;
  final GetMessages getMessages;
  final SendMessage sendMessage;

  ChatBloc({
    required this.getChatList,
    required this.getMessages,
    required this.sendMessage,
  }) : super(ChatInitial()) {
    on<GetChatListEvent>(_onGetChatList);
    on<GetMessagesEvent>(_onGetMessages);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onGetChatList(
    GetChatListEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    
    final result = await getChatList(const NoParams());
    
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chats) => emit(ChatListLoaded(chats)),
    );
  }

  Future<void> _onGetMessages(
    GetMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    
    final result = await getMessages(GetMessagesParams(chatId: event.chatId));
    
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (messages) => emit(MessagesLoaded(event.chatId, messages)),
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is MessagesLoaded) {
      final result = await sendMessage(SendMessageParams(
        chatId: event.chatId,
        content: event.content,
      ));
      
      result.fold(
        (failure) => emit(ChatError(failure.message)),
        (message) {
          final updatedMessages = List<Message>.from(currentState.messages)..add(message);
          emit(MessagesLoaded(event.chatId, updatedMessages));
        },
      );
    }
  }
}

