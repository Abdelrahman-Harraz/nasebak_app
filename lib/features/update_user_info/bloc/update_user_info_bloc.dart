import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nasebak_app/features/update_user_info/bloc/update_user_info_repository.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc
    extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final BaseUpdateUserInfoRepository updateUserInfoRepository;
  UpdateUserInfoBloc({required this.updateUserInfoRepository})
    : super(UpdateUserInfoInitialState()) {
    on<GetEditUserInfoEvent>(_getEditUserInfoEvent);
    on<SaveUserInfoChangeApiEvent>(_saveUserInfoChangeApiEvent);
    on<CheckNewUserInfoEvent>(_checkNewUserInfoEvent);
    on<ValidateEditUserInfoEvent>(_validateEditUserInfoEvent);
  }

  FutureOr<void> _getEditUserInfoEvent(
    GetEditUserInfoEvent event,
    Emitter<UpdateUserInfoState> emit,
  ) async {
    emit(LoadingState());
    emit(await updateUserInfoRepository.getUpdateUserInfo());
  }

  FutureOr<void> _saveUserInfoChangeApiEvent(
    SaveUserInfoChangeApiEvent event,
    Emitter<UpdateUserInfoState> emit,
  ) async {
    emit(LoadingState());
    emit(
      await updateUserInfoRepository.updateUserInfoData(event.userInfoUiModel),
    );
  }

  FutureOr<void> _checkNewUserInfoEvent(
    CheckNewUserInfoEvent event,
    Emitter<UpdateUserInfoState> emit,
  ) {
    if (event.newUserInfoUiModel == event.oldUserInfoUiModel) {
      emit(MustChangeUserInfoState());
    } else {
      emit(UserInfoCanUpdateState());
    }
  }

  FutureOr<void> _validateEditUserInfoEvent(
    ValidateEditUserInfoEvent event,
    Emitter<UpdateUserInfoState> emit,
  ) {
    if (event.userInfoFormKey.currentState?.validate() ?? false) {
      event.userInfoFormKey.currentState!.save();
      emit(UpdateUserInfoValidatedState());
    } else {
      emit(UpdateUserInfoNotValidatedState());
    }
  }
}
