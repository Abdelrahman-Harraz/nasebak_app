import 'package:nasebak_app/features/notifications/bloc/notifications_bloc.dart';
import 'package:nasebak_app/features/notifications/model/notification_ui_model.dart';

abstract class BaseNotificationsRepository {
  Future<NotificationsState> notificationsData();
}

class NotificationsRepository implements BaseNotificationsRepository {
  @override
  Future<NotificationsState> notificationsData() async {
    return LoadedNotificationsSuccessfullyState(
      notificationsList: NotificationUiModel.dummy(),
    );
  }
}
