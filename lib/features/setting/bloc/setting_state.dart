part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitialState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingErrorState extends SettingState {
  final String errorMessage;
  final bool isLocalizationKey;

  const SettingErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class DeleteAccountSuccessfullyState extends SettingState {
  const DeleteAccountSuccessfullyState();
}

class LogOutSuccessfullyState extends SettingState {
  const LogOutSuccessfullyState();
}

class LoadedMyProfileSuccessfullyState extends SettingState {
  final UserInfoUiModel myProfile;

  const LoadedMyProfileSuccessfullyState({required this.myProfile});
}

class ProfileImageUploadedSuccessfullyState extends SettingState {
  final String profileImage;

  const ProfileImageUploadedSuccessfullyState({required this.profileImage});

  @override
  List<Object> get props => [profileImage];
}
