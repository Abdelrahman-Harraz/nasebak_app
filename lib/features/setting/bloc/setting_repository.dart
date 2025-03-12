import 'package:nasebak_app/apis/managers/setting_api_manager.dart';
import 'package:nasebak_app/features/setting/bloc/setting_bloc.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';

abstract class BaseSettingRepository {
  Future<SettingState> profileData();
  Future<SettingState> logOutApi();
  Future<SettingState> deleteAccount();
}

class SettingRepository implements BaseSettingRepository {
  final PreferencesManager preferencesManager;
  final SettingApiManager settingApiManager;

  SettingRepository({
    required this.preferencesManager,
    required this.settingApiManager,
  });
  @override
  Future<SettingState> profileData() async {
    return LoadedMyProfileSuccessfullyState(
      myProfile: UserInfoUiModel.dummyUserInfo,
    );
  }

  @override
  Future<SettingState> logOutApi() async {
    late SettingState moreState;
    await preferencesManager.clearData();
    await Future.delayed(const Duration(seconds: 2));
    moreState = const LogOutSuccessfullyState();
    return moreState;
  }

  @override
  Future<SettingState> deleteAccount() async {
    late SettingState settingState;

    await settingApiManager.deleteAccountApi(
      /// success
      (response) {
        preferencesManager.clearData();
        settingState = const DeleteAccountSuccessfullyState();
      },

      /// fail
      (errorApiModel) {
        settingState = SettingErrorState(
          errorMessage: errorApiModel.message,
          isLocalizationKey: errorApiModel.isMessageLocalizationKey,
        );
      },
    );

    return settingState;
  }
}
