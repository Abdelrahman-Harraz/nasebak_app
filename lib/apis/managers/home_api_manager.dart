import 'package:dio/dio.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/home/home_wrapper.dart';

class HomeApiManager {
  final DioApiManager dioApiManager;

  const HomeApiManager(this.dioApiManager);

  Future<void> homeApi(
    void Function(HomeWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.homeUrl)
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          HomeWrapper wrapper = HomeWrapper.fromJson(extractedData);
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
