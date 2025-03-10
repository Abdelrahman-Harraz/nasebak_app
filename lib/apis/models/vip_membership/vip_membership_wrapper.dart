import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/vip_membership/vip_membership_api_model.dart';

class VipMembershipWrapper extends BaseWrapper {
  final List<VipMembershipApiModel> data;

  const VipMembershipWrapper(
    super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  VipMembershipWrapper.fromJson(super.json)
    : data = List<VipMembershipApiModel>.from(
        json["data"].map((x) => VipMembershipApiModel.fromJson(x)),
      ),
      super.fromJson();
}
