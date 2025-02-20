part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class ValidateOTPEvent extends OtpEvent {
  final String? otpCode;
  const ValidateOTPEvent(this.otpCode);
}

class ValidateOTPWithApiEvent extends OtpEvent {
  final String otpCode;
  final String userName;
  const ValidateOTPWithApiEvent(this.userName, this.otpCode);
}

class ResendOTPApiEvent extends OtpEvent {
  final String mobile;
  const ResendOTPApiEvent(this.mobile);
}

class SaveUserInfoDataEvent extends OtpEvent {
  final SuccessfulOTPResponse successfulOTPResponse;

  const SaveUserInfoDataEvent(this.successfulOTPResponse);
  @override
  List<Object> get props => [successfulOTPResponse];
}
