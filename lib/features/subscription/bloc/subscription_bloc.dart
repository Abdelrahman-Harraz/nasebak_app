import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/subscription/bloc/subscription_repository.dart';
import 'package:nasebak_app/features/subscription/model/subscription_ui_model.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final BaseSubscriptionRepository subscriptionRepository;
  SubscriptionBloc({required this.subscriptionRepository})
    : super(SubscriptionInitialState()) {
    on<GetSubscriptionDataEvent>(_getSubscriptionDataEvent);
  }

  FutureOr<void> _getSubscriptionDataEvent(
    GetSubscriptionDataEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoadingState());
    emit(await subscriptionRepository.subscriptionData());
  }
}
