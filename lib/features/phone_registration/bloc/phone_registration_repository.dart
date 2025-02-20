import 'package:nasebak_app/apis/managers/auth_api_manager.dart';
import 'package:nasebak_app/apis/models/auth/login/phone_registration_send_model.dart';
import 'package:nasebak_app/features/phone_registration/bloc/phone_registration_bloc.dart';

abstract class BasePhoneRegistrationRepository {
  Future<PhoneRegistrationState> registrationWithPhoneApi({
    required String phoneNumber,
    required String countryCode,
  });
}

class PhoneRegistrationRepository implements BasePhoneRegistrationRepository {
  final AuthApiManager authApiManager;

  PhoneRegistrationRepository({required this.authApiManager});

  @override
  Future<PhoneRegistrationState> registrationWithPhoneApi({
    required String phoneNumber,
    required String countryCode,
  }) async {
    late PhoneRegistrationState phoneRegistrationState;
    await authApiManager.registerWithPhoneApi(
      PhoneRegistrationSendModel(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      ),

      /// Success
      (response) {
        phoneRegistrationState = PhoneRegistrationSuccessfullyState(
          response.message,
        );
      },

      /// Fail
      (errorApiModel) {
        phoneRegistrationState = PhoneRegistrationErrorState(
          errorApiModel.message,
          errorApiModel.isMessageLocalizationKey,
        );
      },
    );

    return phoneRegistrationState;
  }
}
