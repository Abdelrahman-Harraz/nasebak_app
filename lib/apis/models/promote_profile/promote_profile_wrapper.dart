import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/promote_profile/promote_profile_api_model.dart';

class PromoteProfileWrapper extends BaseWrapper {
  final List<PromoteProfileApiModel> data;

  const PromoteProfileWrapper(
    super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  PromoteProfileWrapper.fromJson(super.json)
    : data = List<PromoteProfileApiModel>.from(
        json["data"].map((x) => PromoteProfileApiModel.fromJson(x)),
      ),
      super.fromJson();
}
