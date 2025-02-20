part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {
  const OtpLoadingState();
}

class OtpErrorState extends OtpState {
  final String errorMassage;
  final bool isLocalizationKey;
  const OtpErrorState(this.errorMassage, this.isLocalizationKey);

  @override
  List<Object> get props => [errorMassage, isLocalizationKey];
}

class OTPValidatedState extends OtpState {}

class OTPNotValidatedState extends OtpState {
  final String message;
  const OTPNotValidatedState(this.message);
}

class ValidateOTPApiSuccessfullyState extends OtpState {
  final SuccessfulOTPResponse response;
  const ValidateOTPApiSuccessfullyState(this.response);
}

class ResendOTPApiSuccessfullyState extends OtpState {
  final String message;
  const ResendOTPApiSuccessfullyState(this.message);
}

class SaveUserDataSuccessfullyState extends OtpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}
