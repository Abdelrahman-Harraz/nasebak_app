import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class SendChatWrapper extends BaseWrapper {
  const SendChatWrapper(bool super.isSuccess, super.message, super.details);

  SendChatWrapper.fromJson(super.json) : super.fromJson();

  Map<String, dynamic> toJson() => {'isSuccess': isSuccess, 'details': message};
}
