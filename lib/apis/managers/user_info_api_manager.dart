import 'package:dio/dio.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_wrapper.dart';
import 'package:nasebak_app/apis/models/user_info/update_user_info/user_info_send_api_model.dart';
import 'package:nasebak_app/apis/models/user_info/update_user_info/user_info_wrapper.dart';

class UserInfoApiManager {
  final DioApiManager dioApiManager;

  UserInfoApiManager(this.dioApiManager);

  Future<void> getUserInfoApi(
    void Function(GetUserInfoWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.userInfoUrl)
        .then((response) async {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          GetUserInfoWrapper wrapper = GetUserInfoWrapper.fromJson(
            extractedData,
          );
          if (wrapper.isSuccess!) {
            success(wrapper);
          } else {
            ErrorApiModel errorApiModel = ErrorApiModel.fromDetailsModel(
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

  Future<void> updateUserInfoApi(
    UserInfoSendApiModel userInfoSendApiModel,
    void Function(UserInfoWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .post(ApiKeys.updateUserInfoUrl, data: userInfoSendApiModel.toMap())
        .then((response) async {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          UserInfoWrapper wrapper = UserInfoWrapper.fromJson(extractedData);
          if (wrapper.isSuccess!) {
            success(wrapper);
          } else {
            ErrorApiModel errorApiModel = ErrorApiModel.fromDetailsModel(
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
