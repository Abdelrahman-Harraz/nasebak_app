import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/policy/policy_api_model.dart';

class PolicyWrapper extends BaseWrapper {
  final PolicyApiModel? data;
  PolicyWrapper(this.data, super.isSuccess, super.details, super.message);

  PolicyWrapper.fromJson(super.json)
    : data =
          json["data"] != null ? PolicyApiModel.fromJson(json["data"]) : null,
      super.fromJson();
}
