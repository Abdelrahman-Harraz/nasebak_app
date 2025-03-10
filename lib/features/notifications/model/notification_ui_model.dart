import 'package:nasebak_app/apis/models/notifications/notification_api_model.dart';

class NotificationUiModel {
  final int id;
  final String message;
  final String time;
  final String? readAt;

  NotificationUiModel({
    required this.id,
    required this.message,
    required this.time,
    required this.readAt,
  });

  factory NotificationUiModel.fromApiModel({required NotificationApiModel e}) {
    return NotificationUiModel(
      id: e.id,
      message: e.message,
      time: e.createdAt,
      readAt: e.readAt,
    );
  }

  static List<NotificationUiModel> dummy() {
    return [
      // NotificationUiModel(id: 1, message: "Hi", time: "8:50", readAt: "10"),
    ];
  }
}
