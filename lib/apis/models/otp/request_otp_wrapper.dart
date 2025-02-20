import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class RequestOtpWrapper extends BaseWrapper {
  const RequestOtpWrapper(bool super.isSuccess, super.message, super.details);

  RequestOtpWrapper.fromJson(super.json) : super.fromJson();

  Map<String, dynamic> toJson() => {'isSuccess': isSuccess, 'details': message};
}
