import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/subscription/subscription_wrapper.dart';

class SubscriptionApiManager {
  final DioApiManager dioApiManager;
  const SubscriptionApiManager({required this.dioApiManager});

  Future<void> mainSubscriptionScreenApi(
    void Function(SubscriptionWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.subscriptionUrl)
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final SubscriptionWrapper wrapper = SubscriptionWrapper.fromJson(
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
