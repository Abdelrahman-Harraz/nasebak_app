class ChatApiModel {
  final String name;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final String profileImageUrl;

  ChatApiModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.profileImageUrl,
  });

  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return ChatApiModel(
      name: json['name'] as String,
      lastMessage: json['lastMessage'] as String,
      time: DateTime.parse(json['time'] as String),
      unreadCount: json['unreadCount'] as int,
      profileImageUrl: json['profileImageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'time': time.toIso8601String(),
      'unreadCount': unreadCount,
      'profileImageUrl': profileImageUrl,
    };
  }
}
