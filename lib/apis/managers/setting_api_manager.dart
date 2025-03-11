import 'package:dio/dio.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/setting/delete_account_wrapper.dart';

class SettingApiManager {
  final DioApiManager dioApiManager;
  const SettingApiManager(this.dioApiManager);

  Future<void> deleteAccountApi(
    void Function(DeleteAccountWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .delete(ApiKeys.deleteAccountUrl)
        .then((response) {
          final Map<String, dynamic> extractedData = response.data;
          final DeleteAccountWrapper deleteAccountWrapper =
              DeleteAccountWrapper.fromJson(extractedData);
          success(deleteAccountWrapper);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioException(error));
        })
        .catchError((error) {
          final ErrorApiModel errorApiModel = ErrorApiModel.identifyError(
            error: error,
          );
          fail(errorApiModel);
        });
  }
}
