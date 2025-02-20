import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/auth/login/login_wrapper.dart';
import 'package:nasebak_app/apis/models/auth/login/phone_registration_send_model.dart';
import 'package:nasebak_app/apis/models/otp/request_otp_send_model.dart';
import 'package:nasebak_app/apis/models/otp/request_otp_wrapper.dart';
import 'package:nasebak_app/apis/models/otp/verify_otp_send_model.dart';
import 'package:nasebak_app/apis/models/otp/verify_otp_wrapper.dart';

class AuthApiManager {
  final DioApiManager dioApiManager;
  const AuthApiManager(this.dioApiManager);

  Future<void> registerWithPhoneApi(
    PhoneRegistrationSendModel phoneSendModel,
    void Function(PhoneRegistrationWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dioUnauthorized
        .post(ApiKeys.registerWithPhoneUrl, data: phoneSendModel.toMap())
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          PhoneRegistrationWrapper wrapper = PhoneRegistrationWrapper.fromJson(
            extractedData,
          );
          success(wrapper);
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> requestOTPApi(
    RequestOtpSendModelApi requestOtpSendModelApi,
    void Function(RequestOtpWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dioUnauthorized
        .post(
          ApiKeys.registerWithPhoneUrl,
          data: requestOtpSendModelApi.toMap(),
        )
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          RequestOtpWrapper wrapper = RequestOtpWrapper.fromJson(extractedData);
          success(wrapper);
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> verifyOTPApi(
    VerifyOtpSendModelApi verifyOtpSendModelApi,
    void Function(VerifyOtpWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dioUnauthorized
        .post(ApiKeys.registerWithOtpUrl, data: verifyOtpSendModelApi.toMap())
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          VerifyOtpWrapper wrapper = VerifyOtpWrapper.fromJson(extractedData);
          success(wrapper);
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
