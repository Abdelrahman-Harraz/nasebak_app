import 'package:nasebak_app/apis/managers/user_info_api_manager.dart';
import 'package:nasebak_app/features/user_info/bloc/user_info_bloc.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

abstract class BaseUserInfoRepository {
  const BaseUserInfoRepository();

  Future<UserInfoState> getUserInfo();
}

class UserInfoRepository implements BaseUserInfoRepository {
  final UserInfoApiManager profileApiManager;

  UserInfoRepository({required this.profileApiManager});

  @override
  Future<UserInfoState> getUserInfo() async {
    late UserInfoState profileState;
    await profileApiManager.getUserInfoApi(
      (response) {
        profileState = UserInfoLoadedState(
          userInfoUiModel: UserInfoUiModel.fromApi(response.data),
        );
      },
      (errorApiModel) {
        profileState = ErrorState(
          errorMessage: errorApiModel.message,
          isLocalizationKey: errorApiModel.isMessageLocalizationKey,
        );
      },
    );

    return profileState;
  }
}
