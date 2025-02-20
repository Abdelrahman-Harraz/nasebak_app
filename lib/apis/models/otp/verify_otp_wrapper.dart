import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/otp/successful_otp_response.dart';

class VerifyOtpWrapper extends BaseWrapper {
  final SuccessfulOTPResponse? data;

  VerifyOtpWrapper(
    bool super.isSuccess,
    super.message,
    super.details,
    this.data,
  );

  VerifyOtpWrapper.fromJson(super.json)
    : data =
          json["data"] != null
              ? SuccessfulOTPResponse.fromJson(json["data"])
              : null,
      super.fromJson();

  Map<String, dynamic> toJson() => {'success': isSuccess, 'details': message};
}
