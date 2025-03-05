import 'package:nasebak_app/apis/models/chat/chat_api_model.dart';

class ChatUiModel {
  final String name;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final String profileImageUrl;

  ChatUiModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.profileImageUrl,
  });

  factory ChatUiModel.fromApi(ChatApiModel e) {
    return ChatUiModel(
      name: e.name,
      lastMessage: e.lastMessage,
      time: e.time,
      unreadCount: e.unreadCount,
      profileImageUrl: e.profileImageUrl,
    );
  }

  static final dummyConversations = [
    ChatUiModel(
      name: 'عبد الله السعد',
      lastMessage: '؟ كيف حالك اليوم',
      time: DateTime(2025, 3, 5, 18, 55),
      unreadCount: 2,
      profileImageUrl: '',
    ),
    ChatUiModel(
      name: 'محمد السعد',
      lastMessage: '؟ كيف حالك اليوم',
      time: DateTime(2025, 3, 5, 18, 55),
      unreadCount: 1,
      profileImageUrl: '',
    ),
    ChatUiModel(
      name: 'ياسر',
      lastMessage: '؟ كيف حالك اليوم',
      time: DateTime(2025, 3, 5, 18, 55),
      unreadCount: 10,
      profileImageUrl: '',
    ),
  ];
}
