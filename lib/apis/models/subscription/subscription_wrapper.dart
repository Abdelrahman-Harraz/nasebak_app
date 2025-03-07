import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/subscription/subscription_api_model.dart';

class SubscriptionWrapper extends BaseWrapper {
  final SubscriptionApiModel data;

  const SubscriptionWrapper(
    super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  SubscriptionWrapper.fromJson(super.json)
    : data = SubscriptionApiModel.fromJson(json["data"]),
      super.fromJson();
}
