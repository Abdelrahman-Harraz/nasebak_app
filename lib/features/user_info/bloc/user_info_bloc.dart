import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/user_info/bloc/user_info_repository.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final BaseUserInfoRepository userInfoRepository;
  UserInfoBloc({required this.userInfoRepository})
    : super(UserInfoInitialState()) {
    on<GetUserProfileEvent>(_getUserProfileEvent);
  }

  FutureOr<void> _getUserProfileEvent(
    GetUserProfileEvent event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(LoadingState());
    emit(await userInfoRepository.getUserInfo());
  }
}
