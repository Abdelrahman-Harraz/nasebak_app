part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class GetProfileDataEvent extends SettingEvent {}

class DeleteAccountClicked extends SettingEvent {
  const DeleteAccountClicked();
}

class LogOutClickEvent extends SettingEvent {
  const LogOutClickEvent();
}

class UploadProfileImageEvent extends SettingEvent {
  final String imagePath;

  const UploadProfileImageEvent(this.imagePath);
}
