import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/chat/bloc/chat_repository.dart';
import 'package:nasebak_app/features/chat/model/chat_ui_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BaseChatRepository chatRepository;
  ChatBloc({required this.chatRepository}) : super(ChatInitialState()) {
    on<FetchChatConversationsEvent>(_fetchChatConversationsEvent);
    on<SendMessage>(_sendMessage);
    on<MarkMessagesAsRead>(_markMessagesAsRead);
    on<OpenConversationEvent>(_openConversationEvent);
  }

  FutureOr<void> _fetchChatConversationsEvent(
    FetchChatConversationsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    emit(await chatRepository.fetchConversation());
  }

  FutureOr<void> _sendMessage(SendMessage event, Emitter<ChatState> emit) {}

  FutureOr<void> _markMessagesAsRead(
    MarkMessagesAsRead event,
    Emitter<ChatState> emit,
  ) {}

  FutureOr<void> _openConversationEvent(
    OpenConversationEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(ChatConversationOpenState(event.conversation));
  }
}
