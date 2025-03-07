import 'package:nasebak_app/features/subscription/bloc/subscription_bloc.dart';
import 'package:nasebak_app/features/subscription/model/subscription_ui_model.dart';

abstract class BaseSubscriptionRepository {
  Future<SubscriptionState> subscriptionData();
}

class SubscriptionRepository implements BaseSubscriptionRepository {
  @override
  Future<SubscriptionState> subscriptionData() async {
    return SubscriptionDataLoadedSuccessfullyState(
      subscriptionUiModel: SubscriptionUiModel.dummy(),
    );
  }
}
