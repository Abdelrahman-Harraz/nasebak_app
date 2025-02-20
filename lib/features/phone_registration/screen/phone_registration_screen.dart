import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/managers/auth_api_manager.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/phone_registration/bloc/phone_registration_bloc.dart';
import 'package:nasebak_app/features/phone_registration/bloc/phone_registration_repository.dart';
import 'package:nasebak_app/features/phone_registration/widget/phone_number_with_code_form.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/features/widgets/widget_with_background_widget.dart';
import 'package:nasebak_app/only_debug/user_debug_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/build_type/build_type.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_string.dart';
import 'package:nasebak_app/utils/feedback/feedback_message.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/status_bar/statusbar_controller.dart';
import 'package:nasebak_app/utils/validations/app_validate.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  final String initialPhoneCode;
  const PhoneRegistrationScreen({super.key, required this.initialPhoneCode});
  static const argumentPhoneCode = "PhoneCode";

  static void open({required BuildContext context, required String phoneCode}) {
    context.push(
      AppRouter.phoneRegistrationScreen,
      extra: {argumentPhoneCode: phoneCode},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => PhoneRegistrationBloc(
            PhoneRegistrationRepository(
              authApiManager: AuthApiManager(GetIt.I<DioApiManager>()),
            ),
          ),
      child: PhoneRegistrationScreenWithBloc(phoneCode: initialPhoneCode),
    );
  }
}

class PhoneRegistrationScreenWithBloc extends BaseStatefulScreenWidget {
  final String phoneCode;
  const PhoneRegistrationScreenWithBloc({required this.phoneCode, super.key});

  @override
  BaseScreenState<PhoneRegistrationScreenWithBloc> baseScreenCreateState() =>
      _PhoneRegistrationScreenWithBlocState();
}

class _PhoneRegistrationScreenWithBlocState
    extends BaseScreenState<PhoneRegistrationScreenWithBloc>
    with AppValidate {
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController codeTextEditingController =
      TextEditingController();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  String? _selectedCountryCode;
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(color: Colors.transparent);
    if (isDebugMode()) _setDebugEmailPasswordAutomatic();
    Future.microtask(_getInitCountryCode);
  }

  @override
  void dispose() {
    codeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: BlocListener<PhoneRegistrationBloc, PhoneRegistrationState>(
        listener: (context, state) {
          if (state is PhoneRegistrationLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is PhoneRegistrationErrorState) {
            showFeedbackMessage(
              state.isLocalizationKey
                  ? context.translate(state.errorMassage)
                  : state.errorMassage,
            );
          } else if (state is PhoneRegistrationNotValidatedState) {
            autovalidateMode = AutovalidateMode.always;
          } else if (state is PhoneRegistrationValidatedState) {
            _registrationEventApi();
          } else if (state is ChangCountryCodeState) {
            _updateCountryCodeValues(state.country);
          } else if (state is PhoneRegistrationSuccessfullyState) {
            showFeedbackMessage(state.message);
            _openLoginOrOtpScreen();
          }
        },
        child: WidgetWithBackgroundWidget(
          backgroundImage: AppAssetPaths.phoneRegistrationBackground,
          child: _pageContent(),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _pageContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _signUpHeaderWidget(),
          _signUpTextWidget(),
          _signUpPhoneTextWidget(),
          SizedBox(height: 11.h),
          _signInBtn(),
          SizedBox(height: 11.h),
          _signInAsAGuestBtn(),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Widget _signUpHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 63, vertical: 25),
      child: SvgPicture.asset(AppAssetPaths.nasebakLogo),
    );
  }

  Widget _signUpTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 52),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: context.translate(LocalizationKeys.registerScreenTxt),
              ),
              TextSpan(
                text:
                    context
                        .translate(LocalizationKeys.privacyPolicyText)
                        .concatenateNewline,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: context.translate(LocalizationKeys.ours)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpPhoneTextWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: PhoneNumberWithCodeForm(
        codeTextEditingController: codeTextEditingController,
        phoneFormKey: phoneFormKey,
        onSavedPhoneNumber: _onSavedPhoneNumber,
        phoneNumber: _phoneNumber,
        onSelectCountryCode: _onSelectCountryCode,
        selectedCountryCode: _selectedCountryCode,
        autovalidateMode: autovalidateMode,
      ),
    );
  }

  Widget _signInBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: AppElevatedButton(
        label: Text(
          context.translate(LocalizationKeys.login),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonTextColor,
          ),
        ),
        onPressed: _continueClicked,
      ),
    );
  }

  Widget _signInAsAGuestBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: AppElevatedButton(
        label: Text(
          context.translate(LocalizationKeys.singInAsAGuest),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonTextColor,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  PhoneRegistrationBloc get currentBloc =>
      context.read<PhoneRegistrationBloc>();

  void _getInitCountryCode() {
    _selectedCountryCode = widget.phoneCode.replaceRange(0, 1, "+");
    Country country = CountryService().getAll().firstWhere(
      (country) => country.phoneCode == _selectedCountryCode,
      orElse: () => CountryService().findByCode("EG")!,
    );
    _onSelectCountryCode(country);
  }

  void _onSelectCountryCode(Country country) {
    currentBloc.add(ChangCountryCodeEvent(country: country));
  }

  void _registrationEventApi() {
    currentBloc.add(
      RegisterWithPhoneEvent(
        phone: _phoneNumber!,
        countryCode: _selectedCountryCode!,
      ),
    );
  }

  void _updateCountryCodeValues(Country country) {
    _selectedCountryCode = country.phoneCode;
  }

  void _continueClicked() {
    context.push(AppRouter.otpScreen);
  }

  void _openLoginOrOtpScreen() {
    context.push(AppRouter.otpScreen);
  }

  void _onSavedPhoneNumber(String? value) {
    _phoneNumber = value!;
  }

  void _setDebugEmailPasswordAutomatic() {
    _phoneNumber = UserDebugModel.phone;
    _selectedCountryCode = UserDebugModel.country;
  }
}
