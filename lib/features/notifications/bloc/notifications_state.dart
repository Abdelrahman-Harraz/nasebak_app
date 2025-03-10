part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitialState extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsErrorState extends NotificationsState {
  final String errorMessage;
  final bool isLocalizationKey;

  const NotificationsErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
  @override
  List<Object> get props => [identityHashCode(this)];
}

class LoadedNotificationsSuccessfullyState extends NotificationsState {
  final List<NotificationUiModel> notificationsList;

  const LoadedNotificationsSuccessfullyState({required this.notificationsList});

  @override
  List<Object> get props => [notificationsList];
}
