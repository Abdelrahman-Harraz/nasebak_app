import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:nasebak_app/features/phone_registration/bloc/phone_registration_repository.dart';

part 'phone_registration_event.dart';
part 'phone_registration_state.dart';

class PhoneRegistrationBloc
    extends Bloc<PhoneRegistrationEvent, PhoneRegistrationState> {
  final BasePhoneRegistrationRepository phoneRegistrationRepository;
  PhoneRegistrationBloc(this.phoneRegistrationRepository)
    : super(PhoneRegistrationInitialState()) {
    on<PhoneRegistrationEvent>((event, emit) {
      on<ValidatePhoneEvent>(_validatePhoneEvent);
      on<RegisterWithPhoneEvent>(_registerWithPhoneEvent);
      on<ChangCountryCodeEvent>(_changCountryCodeEvent);
    });
  }

  FutureOr<void> _validatePhoneEvent(
    ValidatePhoneEvent event,
    Emitter<PhoneRegistrationState> emit,
  ) {
    if (event.formKey.currentState?.validate() ?? false) {
      event.formKey.currentState?.save();
      emit(PhoneRegistrationValidatedState());
    } else {
      emit(PhoneRegistrationNotValidatedState());
    }
  }

  FutureOr<void> _registerWithPhoneEvent(
    RegisterWithPhoneEvent event,
    Emitter<PhoneRegistrationState> emit,
  ) async {
    emit(PhoneRegistrationLoadingState());
    emit(
      await phoneRegistrationRepository.registrationWithPhoneApi(
        countryCode: event.countryCode,
        phoneNumber: event.phone,
      ),
    );
  }

  FutureOr<void> _changCountryCodeEvent(
    ChangCountryCodeEvent event,
    Emitter<PhoneRegistrationState> emit,
  ) {
    emit(ChangCountryCodeState(country: event.country));
  }
}
