part of 'update_user_info_bloc.dart';

sealed class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInfoInitialState extends UpdateUserInfoState {}

class LoadingState extends UpdateUserInfoState {}

class ErrorState extends UpdateUserInfoState {
  final String errorMessage;
  final bool isLocalizationKey;

  const ErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class EditUserInfoLoadedState extends UpdateUserInfoState {
  final UserInfoUiModel userInfoUiModel;

  const EditUserInfoLoadedState({required this.userInfoUiModel});
  @override
  List<Object> get props => [userInfoUiModel];
}

class ChangeUserInfoSuccessfullyState extends UpdateUserInfoState {
  final String message;

  const ChangeUserInfoSuccessfullyState(this.message);
  @override
  List<Object> get props => [identityHashCode(this)];
}

class UpdateUserInfoValidatedState extends UpdateUserInfoState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class UpdateUserInfoNotValidatedState extends UpdateUserInfoState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class MustChangeUserInfoState extends UpdateUserInfoState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class UserInfoCanUpdateState extends UpdateUserInfoState {
  @override
  List<Object> get props => [identityHashCode(this)];
}
