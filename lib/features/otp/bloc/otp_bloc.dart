import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nasebak_app/apis/models/otp/successful_otp_response.dart';
import 'package:nasebak_app/features/otp/bloc/otp_repository.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/validations/validator.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final BaseOtpRepository otpRepository;
  OtpBloc({required this.otpRepository}) : super(OtpInitialState()) {
    on<OtpEvent>((event, emit) {
      on<ValidateOTPEvent>(_validateOTPEvent);
      on<ValidateOTPWithApiEvent>(_validateOTPWithApiEvent);
      on<ResendOTPApiEvent>(_resendOTPApiEvent);
      on<SaveUserInfoDataEvent>(_saveUserInfoDataEvent);
    });
  }

  FutureOr<void> _validateOTPEvent(
    ValidateOTPEvent event,
    Emitter<OtpState> emit,
  ) async {
    ValidationState validationState = Validator.validateNumber(
      event.otpCode,
      lengths: [4, 5],
    );
    switch (validationState) {
      case ValidationState.empty:
        emit(const OTPNotValidatedState(LocalizationKeys.otpRequired));
      case ValidationState.formatting:
        emit(const OTPNotValidatedState(LocalizationKeys.otpInvalid));
      case ValidationState.valid:
        emit(OTPValidatedState());
    }
  }

  FutureOr<void> _validateOTPWithApiEvent(
    ValidateOTPWithApiEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpLoadingState());
    emit(await otpRepository.validateOtpApi(event.userName, event.otpCode));
  }

  FutureOr<void> _resendOTPApiEvent(
    ResendOTPApiEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpLoadingState());
    emit(await otpRepository.resendOtpApi(mobile: event.mobile));
  }

  FutureOr<void> _saveUserInfoDataEvent(
    SaveUserInfoDataEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(const OtpLoadingState());
    emit(await otpRepository.savaUserDataData(event.successfulOTPResponse));
  }
}
