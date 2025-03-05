class MessageModel {
  final String senderName;
  final String message;
  final bool isCurrentUser;
  final String imageUrl;

  MessageModel({
    required this.senderName,
    required this.message,
    required this.isCurrentUser,
    required this.imageUrl,
  });

  static final List<MessageModel> messages = [
    MessageModel(
      senderName: "عبد الحق",
      message: "السلام عليكم كيف حالك ؟",
      isCurrentUser: false,
      imageUrl: "",
    ),
    MessageModel(
      senderName: "مرام",
      message: "بخير وأنت ؟",
      isCurrentUser: true,
      imageUrl: "",
    ),
    MessageModel(
      senderName: "عبد الحق",
      message: "من وين انت ؟",
      isCurrentUser: false,
      imageUrl: "",
    ),
    MessageModel(
      senderName: "مرام",
      message: "من السعودية وأنت ؟",
      isCurrentUser: true,
      imageUrl: "",
    ),
    MessageModel(
      senderName: "عبد الحق",
      message: "من الرياض",
      isCurrentUser: false,
      imageUrl: "",
    ),
    MessageModel(
      senderName: "مرام",
      message: "ممتاز وانا من الرياض",
      isCurrentUser: true,
      imageUrl: "",
    ),
  ];
}
