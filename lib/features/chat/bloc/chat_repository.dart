import 'package:nasebak_app/features/chat/bloc/chat_bloc.dart';

import 'package:nasebak_app/features/chat/model/chat_ui_model.dart';

abstract class BaseChatRepository {
  Future<ChatState> fetchConversation();
}

class ChatRepository implements BaseChatRepository {
  @override
  Future<ChatState> fetchConversation() async {
    final dummyConversations = ChatUiModel.dummyConversations;

    return ChatLoaded(chatUiModel: dummyConversations);
  }
}
