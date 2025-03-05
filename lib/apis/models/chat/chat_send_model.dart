class ChatSendModel {
  final String conversationId;
  final String message;

  ChatSendModel({required this.conversationId, required this.message});

  Map<String, dynamic> toMap() {
    return {'conversationId': conversationId, 'message': message};
  }
}
