import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:nasebak_app/apis/models/membership/membership_wrapper.dart';

class MembershipApiManager {
  final DioApiManager dioApiManager;
  const MembershipApiManager({required this.dioApiManager});

  Future<void> membershipApi(
    void Function(MembershipWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.membershipUrl)
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final MembershipWrapper wrapper = MembershipWrapper.fromJson(
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
