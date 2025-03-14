import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/features/setting/bloc/setting_repository.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final BaseSettingRepository settingRepository;
  SettingBloc({required this.settingRepository})
    : super(SettingInitialState()) {
    on<DeleteAccountClicked>(_deleteClickEvent);
    on<LogOutClickEvent>(_logOutClickEvent);
    on<GetProfileDataEvent>(_getProfileDataEvent);
    on<UploadProfileImageEvent>(_uploadProfileImageEvent);
  }

  FutureOr<void> _deleteClickEvent(
    DeleteAccountClicked event,
    Emitter<SettingState> emit,
  ) async {
    emit(await settingRepository.deleteAccount());
  }

  FutureOr<void> _logOutClickEvent(
    LogOutClickEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(await settingRepository.logOutApi());
  }

  FutureOr<void> _getProfileDataEvent(
    GetProfileDataEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(await settingRepository.profileData());
  }

  FutureOr<void> _uploadProfileImageEvent(
    UploadProfileImageEvent event,
    Emitter<SettingState> emit,
  ) {
    emit(ProfileImageUploadedSuccessfullyState(profileImage: event.imagePath));
  }
}
