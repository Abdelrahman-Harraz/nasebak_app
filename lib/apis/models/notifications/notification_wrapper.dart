import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/notifications/notification_api_model.dart';

class NotificationWrapper extends BaseWrapper {
  final List<NotificationApiModel> data;

  const NotificationWrapper(
    super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  NotificationWrapper.fromJson(super.json)
    : data = List<NotificationApiModel>.from(
        json["data"].map((x) => NotificationApiModel.fromJson(x)),
      ),
      super.fromJson();
}
