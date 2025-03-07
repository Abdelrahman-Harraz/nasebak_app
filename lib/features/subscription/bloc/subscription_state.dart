part of 'subscription_bloc.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

final class SubscriptionInitialState extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState {
  const SubscriptionLoadingState();
}

class SubscriptionErrorState extends SubscriptionState {
  final String errorMessage;
  final bool isLocalizationKey;
  const SubscriptionErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });

  @override
  List<Object> get props => [errorMessage, isLocalizationKey];
}

class SubscriptionDataLoadedSuccessfullyState extends SubscriptionState {
  final SubscriptionUiModel subscriptionUiModel;
  const SubscriptionDataLoadedSuccessfullyState({
    required this.subscriptionUiModel,
  });
}
