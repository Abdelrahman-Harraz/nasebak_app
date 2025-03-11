import 'package:nasebak_app/features/user_info/bloc/user_info_bloc.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

abstract class BaseUserInfoRepository {
  Future<UserInfoState> getUserInfo();
}

class UserInfoRepository implements BaseUserInfoRepository {
  @override
  Future<UserInfoState> getUserInfo() async {
    return UserInfoLoadedState(userInfoUiModel: UserInfoUiModel.dummyUserInfo);
  }
}
