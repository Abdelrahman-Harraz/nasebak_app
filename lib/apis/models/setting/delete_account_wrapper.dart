import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class DeleteAccountWrapper extends BaseWrapper {
  DeleteAccountWrapper(super.isSuccess, super.message, super.details);
  DeleteAccountWrapper.fromJson(super.json) : super.fromJson();
}
