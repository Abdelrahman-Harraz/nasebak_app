part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchChatConversationsEvent extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String conversationId;
  final String message;

  const SendMessage({required this.conversationId, required this.message});

  @override
  List<Object> get props => [conversationId, message];
}

class MarkMessagesAsRead extends ChatEvent {
  final String conversationId;

  const MarkMessagesAsRead({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}

class OpenConversationEvent extends ChatEvent {
  final ChatUiModel conversation;

  const OpenConversationEvent(this.conversation);
}
