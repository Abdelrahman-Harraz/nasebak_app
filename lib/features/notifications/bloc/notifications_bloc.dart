import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/notifications/bloc/notifications_repository.dart';
import 'package:nasebak_app/features/notifications/model/notification_ui_model.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final BaseNotificationsRepository notificationsRepository;
  NotificationsBloc({required this.notificationsRepository})
    : super(NotificationsInitialState()) {
    on<GetNotificationsDataEvent>(_getNotificationsDataEvent);
  }

  FutureOr<void> _getNotificationsDataEvent(
    GetNotificationsDataEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoadingState());
    emit(await notificationsRepository.notificationsData());
  }
}
