part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetEditUserInfoEvent extends UpdateUserInfoEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SaveUserInfoChangeApiEvent extends UpdateUserInfoEvent {
  final UserInfoUiModel userInfoUiModel;

  const SaveUserInfoChangeApiEvent(this.userInfoUiModel);
  @override
  List<Object> get props => [userInfoUiModel];
}

class ValidateEditUserInfoEvent extends UpdateUserInfoEvent {
  final GlobalKey<FormState> userInfoFormKey;

  const ValidateEditUserInfoEvent(this.userInfoFormKey);
}

class CheckNewUserInfoEvent extends UpdateUserInfoEvent {
  final UserInfoUiModel oldUserInfoUiModel;
  final UserInfoUiModel newUserInfoUiModel;

  const CheckNewUserInfoEvent(this.oldUserInfoUiModel, this.newUserInfoUiModel);
  @override
  List<Object> get props => [oldUserInfoUiModel, newUserInfoUiModel];
}
