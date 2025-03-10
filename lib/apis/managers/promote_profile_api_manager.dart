import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/promote_profile/promote_profile_wrapper.dart';

class PromoteProfileApiManager {
  final DioApiManager dioApiManager;
  const PromoteProfileApiManager({required this.dioApiManager});

  Future<void> promoteProfileApi(
    void Function(PromoteProfileWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.membershipUrl)
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final PromoteProfileWrapper wrapper = PromoteProfileWrapper.fromJson(
            extractedData,
          );
          if (wrapper.isSuccess!) {
            success(wrapper);
          } else {
            final ErrorApiModel errorApiModel = ErrorApiModel.fromDetailsModel(
              wrapper.details ?? DetailsModel.getUnknownError(),
            );
            fail(errorApiModel);
          }
        })
        .catchError((onError) {
          fail(ErrorApiModel.identifyError());
        });
  }
}
