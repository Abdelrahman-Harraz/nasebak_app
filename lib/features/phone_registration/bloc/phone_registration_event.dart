part of 'phone_registration_bloc.dart';

sealed class PhoneRegistrationEvent extends Equatable {
  const PhoneRegistrationEvent();

  @override
  List<Object?> get props => [];
}

class ValidatePhoneEvent extends PhoneRegistrationEvent {
  final GlobalKey<FormState> formKey;
  const ValidatePhoneEvent(this.formKey);
  @override
  List<Object> get props => [identityHashCode(this)];
}

class RegisterWithPhoneEvent extends PhoneRegistrationEvent {
  final String phone;
  final String countryCode;

  const RegisterWithPhoneEvent({
    required this.phone,
    required this.countryCode,
  });
  @override
  List<Object> get props => [phone, countryCode];
}

class ChangCountryCodeEvent extends PhoneRegistrationEvent {
  final Country country;

  const ChangCountryCodeEvent({required this.country});
  @override
  List<Object?> get props => [country.countryCode];
}
