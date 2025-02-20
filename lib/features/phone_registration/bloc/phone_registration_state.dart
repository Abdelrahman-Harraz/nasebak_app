part of 'phone_registration_bloc.dart';

sealed class PhoneRegistrationState extends Equatable {
  const PhoneRegistrationState();

  @override
  List<Object?> get props => [];
}

final class PhoneRegistrationInitialState extends PhoneRegistrationState {}

class PhoneRegistrationLoadingState extends PhoneRegistrationState {}

class PhoneRegistrationErrorState extends PhoneRegistrationState {
  final String errorMassage;
  final bool isLocalizationKey;
  const PhoneRegistrationErrorState(this.errorMassage, this.isLocalizationKey);

  @override
  List<Object> get props => [errorMassage, isLocalizationKey];
}

class PhoneRegistrationValidatedState extends PhoneRegistrationState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class PhoneRegistrationNotValidatedState extends PhoneRegistrationState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class PhoneRegistrationSuccessfullyState extends PhoneRegistrationState {
  final String message;

  const PhoneRegistrationSuccessfullyState(this.message);
}

/// ChangCountryCode State
class ChangCountryCodeState extends PhoneRegistrationState {
  final Country country;
  const ChangCountryCodeState({required this.country});
  @override
  List<Object?> get props => [country.countryCode];
}
