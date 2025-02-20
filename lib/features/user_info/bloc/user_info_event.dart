part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserInfoEvent {
  @override
  List<Object> get props => [identityHashCode(this)];
}
