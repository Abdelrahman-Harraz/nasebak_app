part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ErrorState extends ChatState {
  final String errorMessage;
  final bool isLocalizationKey;

  const ErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class ChatLoaded extends ChatState {
  final List<ChatUiModel> chatUiModel;

  const ChatLoaded({required this.chatUiModel});

  @override
  List<Object> get props => [chatUiModel];
}

class MessageSent extends ChatState {
  final ChatUiModel message;

  const MessageSent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesMarkedAsRead extends ChatState {
  final List<ChatUiModel> conversations;

  const MessagesMarkedAsRead({required this.conversations});

  @override
  List<Object> get props => [conversations];
}

class ChatConversationOpenState extends ChatState {
  final ChatUiModel conversation;

  const ChatConversationOpenState(this.conversation);
}
