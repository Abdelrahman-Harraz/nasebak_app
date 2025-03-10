import 'package:equatable/equatable.dart';

class NotificationApiModel extends Equatable {
  final int id;
  final String message;
  final String createdAt;
  final String? readAt;

  const NotificationApiModel({
    required this.id,
    required this.message,
    required this.createdAt,
    this.readAt,
  });

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) {
    return NotificationApiModel(
      id: json['id'] as int,
      message: json['message'] as String,
      createdAt: json['created_at'] as String,
      readAt: json['read_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, message, createdAt, readAt];
}
