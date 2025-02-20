import 'package:nasebak_app/features/update_user_info/bloc/update_user_info_bloc.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

abstract class BaseUpdateUserInfoRepository {
  const BaseUpdateUserInfoRepository();

  Future<UpdateUserInfoState> updateUserInfoData(
    UserInfoUiModel updatedUserInfo,
  );

  Future<UpdateUserInfoState> getUpdateUserInfo();
}

class UpdateUserInfoRepository implements BaseUpdateUserInfoRepository {
  const UpdateUserInfoRepository();

  @override
  Future<UpdateUserInfoState> updateUserInfoData(
    UserInfoUiModel updatedUserInfo,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return ChangeUserInfoSuccessfullyState("User info updated successfully.");
  }

  @override
  Future<UpdateUserInfoState> getUpdateUserInfo() async {
    await Future.delayed(Duration(seconds: 1));
    return EditUserInfoLoadedState(
      userInfoUiModel: UserInfoUiModel(firstName: "", id: 1),
    );
  }
}
