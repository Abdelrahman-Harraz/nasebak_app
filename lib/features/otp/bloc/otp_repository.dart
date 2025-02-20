import 'package:nasebak_app/apis/managers/auth_api_manager.dart';
import 'package:nasebak_app/apis/models/otp/request_otp_send_model.dart';
import 'package:nasebak_app/apis/models/otp/successful_otp_response.dart';
import 'package:nasebak_app/apis/models/otp/verify_otp_send_model.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';

import 'otp_bloc.dart';

abstract class BaseOtpRepository {
  Future<OtpState> validateOtpApi(String userName, String code);
  Future<OtpState> resendOtpApi({required String mobile});
  Future<OtpState> savaUserDataData(SuccessfulOTPResponse response);
}

class OtpRepository implements BaseOtpRepository {
  final PreferencesManager preferencesManager;
  final AuthApiManager authApiManager;

  const OtpRepository({
    required this.preferencesManager,
    required this.authApiManager,
  });

  @override
  Future<OtpState> validateOtpApi(String userName, String code) async {
    late OtpState otpState;
    await authApiManager.verifyOTPApi(
      VerifyOtpSendModelApi(userName, code),
      (verifyOtpWrapper) {
        otpState = ValidateOTPApiSuccessfullyState(verifyOtpWrapper.data!);
      },
      (errorApiModel) {
        otpState = OtpErrorState(
          errorApiModel.message,
          errorApiModel.isMessageLocalizationKey,
        );
      },
    );

    return otpState;
  }

  @override
  Future<OtpState> resendOtpApi({required String mobile}) async {
    late OtpState otpState;
    await authApiManager.requestOTPApi(
      RequestOtpSendModelApi(mobile: mobile),

      /// Success Registration
      (requestOtpWrapper) {
        otpState = ResendOTPApiSuccessfullyState(requestOtpWrapper.message);
      },
      (errorApiModel) {
        otpState = OtpErrorState(
          errorApiModel.message,
          errorApiModel.isMessageLocalizationKey,
        );
      },
    );

    return otpState;
  }

  @override
  Future<OtpState> savaUserDataData(SuccessfulOTPResponse response) async {
    late OtpState otpState;
    await preferencesManager.clearData();
    await preferencesManager.setUserInfo(
      token: response.token,
      userFullName: response.name ?? "",
      userId: response.id,
    );

    otpState = SaveUserDataSuccessfullyState();
    return otpState;
  }
}
