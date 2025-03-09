import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/membership/membership_api_model.dart';

class MembershipWrapper extends BaseWrapper {
  final List<MembershipApiModel> data;

  const MembershipWrapper(
    super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  MembershipWrapper.fromJson(super.json)
    : data = List<MembershipApiModel>.from(
        json["data"]["surveyItems"].map((x) => MembershipApiModel.fromJson(x)),
      ),
      super.fromJson();
}
