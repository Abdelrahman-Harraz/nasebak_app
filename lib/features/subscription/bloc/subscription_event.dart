part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class GetSubscriptionDataEvent extends SubscriptionEvent {
  const GetSubscriptionDataEvent();
}
