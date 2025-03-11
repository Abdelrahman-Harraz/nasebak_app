import 'package:dio/dio.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/search/search_send_api_model.dart';
import 'package:nasebak_app/apis/models/search/search_wrapper.dart';

class SearchApiManager {
  final DioApiManager dioApiManager;

  SearchApiManager(this.dioApiManager);

  Future<void> searchApi(
    SearchSendApiModel searchSendApiModel,
    void Function(SearchWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.searchUrl, queryParameters: searchSendApiModel.toMap())
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          SearchWrapper wrapper = SearchWrapper.fromJson(extractedData);
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
