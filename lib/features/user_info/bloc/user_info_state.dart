part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitialState extends UserInfoState {}

class LoadingState extends UserInfoState {}

class ErrorState extends UserInfoState {
  final String errorMessage;
  final bool isLocalizationKey;

  const ErrorState({
    required this.errorMessage,
    required this.isLocalizationKey,
  });
}

class UserInfoLoadedState extends UserInfoState {
  final UserInfoUiModel userInfoUiModel;

  const UserInfoLoadedState({required this.userInfoUiModel});
  @override
  List<Object> get props => [userInfoUiModel];
}
