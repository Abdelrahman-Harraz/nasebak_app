import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/managers/auth_api_manager.dart';
import 'package:nasebak_app/apis/models/otp/successful_otp_response.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/otp/bloc/otp_bloc.dart';
import 'package:nasebak_app/features/otp/bloc/otp_repository.dart';
import 'package:nasebak_app/features/otp/widgets/otp_timer_widget.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_buttons.dart';
import 'package:nasebak_app/only_debug/user_debug_model.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/build_type/build_type.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/feedback/feedback_message.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/validations/app_validate.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    OtpRepository otpRepository = OtpRepository(
      authApiManager: AuthApiManager(dioApiManager),
      preferencesManager: GetIt.I<PreferencesManager>(),
    );
    return BlocProvider<OtpBloc>(
      create: (BuildContext context) => OtpBloc(otpRepository: otpRepository),
      child: OtpScreenWithBloc(),
    );
  }
}

class OtpScreenWithBloc extends BaseStatefulScreenWidget {
  const OtpScreenWithBloc({super.key});

  @override
  BaseScreenState<OtpScreenWithBloc> baseScreenCreateState() =>
      _OtpScreenWithBlocState();
}

class _OtpScreenWithBlocState extends BaseScreenState<OtpScreenWithBloc>
    with AppValidate {
  String? _otp;

  @override
  void initState() {
    super.initState();
    if (isDebugMode()) _setDebugOtpAutomatic();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is OtpErrorState) {
            showFeedbackMessage(
              state.isLocalizationKey
                  ? context.translate(state.errorMassage)
                  : state.errorMassage,
            );
          } else if (state is OTPNotValidatedState) {
            showFeedbackMessage(context.translate(state.message));
          } else if (state is OTPValidatedState) {
          } else if (state is ValidateOTPApiSuccessfullyState) {
            _saveUserInfoDataEvent(state.response);
          } else if (state is SaveUserDataSuccessfullyState) {
            _openPolicyScreen();
          } else if (state is ResendOTPApiSuccessfullyState) {
            showFeedbackMessage(state.message);
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: _buildOtpWidget(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
        onTap: _backClicked,
        child: Icon(
          Icons.arrow_back,
          color: AppColors.otpBackIconColor,
          size: 41,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildOtpWidget() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _otpHeaderWidget(),
            const SizedBox(height: 30),
            _enterOtpTextWidget(),
            const SizedBox(height: 7),
            _otpSentTextWidget(),
            const SizedBox(height: 20),
            _loginFormWidget(),
          ],
        ),
      ),
    );
  }

  Widget _otpHeaderWidget() {
    return SvgPicture.asset(AppAssetPaths.nasebakLogo, width: 237, height: 266);
  }

  Widget _enterOtpTextWidget() {
    return Text(
      context.translate(LocalizationKeys.enterOtp),
      style: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _otpSentTextWidget() {
    return Text(
      context.translate(LocalizationKeys.otpSent),
      style: TextStyle(
        color: AppColors.otpSentText,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  Widget _loginFormWidget() {
    return AutofillGroup(
      child: Column(
        children: [
          OtpTimerWidget(
            onCodeCompleted: _otpSaved,
            countdownTimeToEnableResend: const Duration(seconds: 60),
            onResendClicked: _resendOtp,
          ),

          _confirmButtonWidget(),
        ],
      ),
    );
  }

  Widget _confirmButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 53, vertical: 25),
      child: AppElevatedButton(
        onPressed: _openPolicyScreen,

        label: Text(
          context.translate(LocalizationKeys.confirmOtp),
          style: TextStyle(color: AppColors.banksCardBoarder, fontSize: 16),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////
  void _setDebugOtpAutomatic() {
    _otp = UserDebugModel.defaultOtpCode;
  }

  void _otpSaved(String value) {
    _otp = value;
  }

  void _resendOtp() {}

  OtpBloc get currentBloc => BlocProvider.of<OtpBloc>(context);

  void _nextClicked() {
    if (_otp == null || _otp!.length != 5) {
      showFeedbackMessage(context.translate(LocalizationKeys.otpInvalid));
      return;
    }
    currentBloc.add(ValidateOTPEvent(_otp));
  }

  void _saveUserInfoDataEvent(SuccessfulOTPResponse response) {
    currentBloc.add(SaveUserInfoDataEvent(response));
  }

  void _backClicked() {
    Navigator.of(context).pop();
  }

  void _openPolicyScreen() {
    context.push(AppRouter.policyScreen);
  }
}
