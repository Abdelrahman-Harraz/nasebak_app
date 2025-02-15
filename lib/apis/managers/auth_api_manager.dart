import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/auth/login/phone_registration_send_model.dart';
import 'package:nasebak_app/apis/models/auth/login/login_wrapper.dart';
import 'package:dio/dio.dart';

class AuthApiManager {
  final DioApiManager dioApiManager;

  const AuthApiManager({required this.dioApiManager});

  Future<void> registerWithPhoneApi(
    PhoneRegistrationSendModel phoneRegistrationSendModel,
    void Function(PhoneRegistrationWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dioUnauthorized
        .post(
          ApiKeys.registerWithPhoneUrl,
          data: phoneRegistrationSendModel.toMap(),
        )
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final PhoneRegistrationWrapper wrapper =
              PhoneRegistrationWrapper.fromJson(extractedData);
          if (wrapper.isSuccess!) {
            success(wrapper);
          } else {
            final ErrorApiModel errorApiModel = ErrorApiModel.fromDetailsModel(
              wrapper.details ?? DetailsModel.getUnknownError(),
            );
            fail(errorApiModel);
          }
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioException(error));
        })
        .catchError((onError) {
          fail(ErrorApiModel.identifyError());
        });
  }
}
