import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class GetUserInfoWrapper extends BaseWrapper {
  final GetUserInfoApiModel data;
  GetUserInfoWrapper(this.data, super.isSuccess, super.details, super.message);

  GetUserInfoWrapper.fromJson(super.json)
    : data = GetUserInfoApiModel.fromJson(json["data"]),
      super.fromJson();

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'details': details?.toJson(),
  };
}
