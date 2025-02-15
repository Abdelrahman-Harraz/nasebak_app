import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';

class PhoneRegistrationWrapper extends BaseWrapper {
  final bool isExist;

  const PhoneRegistrationWrapper(
    this.isExist,
    super.isSuccess,
    super.message,
    super.details,
  );

  PhoneRegistrationWrapper.fromJson(super.json)
    : isExist = json["data"]['isEXist'],
      super.fromJson();
}
