import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class UserInfoWrapper extends BaseWrapper {
  UserInfoWrapper(super.isSuccess, super.details, super.message);

  UserInfoWrapper.fromJson(super.json) : super.fromJson();
}
