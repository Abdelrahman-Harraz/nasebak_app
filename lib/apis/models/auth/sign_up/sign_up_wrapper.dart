import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class SignUpWrapper extends BaseWrapper {
  const SignUpWrapper(super.isSuccess, super.message, super.details);

  SignUpWrapper.fromJson(super.json) : super.fromJson();
}
