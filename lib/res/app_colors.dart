import 'package:flutter/material.dart';

/// to control all colors, app theme, without any need to dig into code
/// any new color or existing color will have a const with its value
/// there is a stand alone variable for any widget, text, image or icon

abstract final class AppColors {
  const AppColors._();
  static const Color _black = Colors.black;
  static const Color _white = Colors.white;
  static const Color _transparent = Colors.transparent;
  static const Color _red = Colors.red;
  static const Color _green = Colors.lightGreenAccent;
  static const Color _grey = Colors.grey;
  static const Color _jaffa = Color(0xFFF47B3D);
  static const Color _yellowOrange = Color(0xffFAAF40);
  static const Color _frenchGray = Color(0xffCFCFD0);
  static const Color _cloudBurst = Color(0xff183059);
  static const Color _silver = Color(0xffC4C4C4);
  static const Color _gray = Color(0xff898989);
  static const Color _mineShaft = Color(0xff2D2D2D);
  static const Color _dustyGray = Color(0xff9A9A9A);
  static const Color _cararra = Color(0xffF1F2EC);
  static const Color _aquaSpring = Color(0xffECF9F6);
  static const Color _wildSand = Color(0xFFF5F5F5);
  static const Color _greenHaze = Color(0xff009444);
  static const Color _mineralGreen = Color(0xFF374C47);
  static const Color _doveGray = Color(0xFF707070);
  static const Color _scorpion = Color(0x61606060);
  static const Color _brickRed = Color(0xFFC52943);
  static const Color _outrageousOrange = Color(0xFFFF5C3D);
  static const Color _blackWith67Opacity = Color(0xAB000000);
  static const Color _concrete = Color(0xFFF2F2F2);
  static const Color _thunderbird = Color(0xFFD5381B);
  static const Color _castro = Color(0xFF4E001C);
  static const Color _coffeeBean = Color(0xFF1E0B11);
  static const Color _coffeeBean2 = Color(0xFF1F0B11);
  static const Color _radicalRed = Color(0xFFFD2B74);
  static const Color _flamingo = Color(0xFFF25031);
  static const Color _mePink = Color(0xFFFE79A7);
  static const Color _newYorkPink = Color(0xFFD18374);
  static const Color _oceanGreen = Color(0xFF44B775);
  static const Color _fountainBlue = Color(0xFF5BBDC1);
  static const Color _roseBud = Color(0xFFF9BB8B);
  static const Color _sweetCorn = Color(0xFFF9DF8B);
  static const Color _nobel = Color(0xFFB5B5B5);
  static const Color _goldenGrass = Color(0xFFD6B326);
  static const Color _silverChalice = Color(0xFFAEAEAE);
  static const Color _corn = Color(0xFFDFAB00);
  static const Color _alto = Color(0xffD9D9D9);
  static const Color _alto2 = Color(0xffCECECE);
  static const Color _geyser = Color(0xffCBD6DE);
  static const Color _guardsmanRed = Color(0xFFB90000);
  static const Color _redBerry = Color(0xFF9B1800);

  /// app main theme ...
  static const colorPrimary = _white;
  static const scaffoldBackground = _white;
  static const appBarBackground = _white;
  static const transparentColor = _transparent;
  static const buttonTextColor = _white;
  static const iconTheme = _jaffa;
  static const floatActionBtnBackgroundColor = _white;
  static const floatActionBtnforegroundColor = _white;
  static const bottomNavigationBarBackground = _white;
  static const appBarTextColor = _white;
  static const appButtonGreenText = _greenHaze;
  static const appButtonWhiteBackground = _white;
  static const appButtonBorder = _white;
  static const dropDownBorder = _cararra;
  static const blackColor = _black;

  /// text colors
  static const headlineMedium = _white;
  static const bodySmall = _silver;
  static const titleSmall = _gray;
  static const bodyMedium = _jaffa;
  static const bodyLarge = _white;
  static const headlineSmall = _dustyGray;
  static const headlineLarge = _mineShaft;
  static const titleMedium = _black;
  static const labelSmall = _alto2;

  /// app form field
  static const appFormFieldFill = _white;
  static const enabledAppFormFieldBorder = _cararra;
  static const suffixIcon = _gray;
  static const focusIcon = _yellowOrange;
  static const formFieldText = _black;
  static const formFieldProfileEnableBorder = _frenchGray;
  static const formFieldProfileFocusIBorder = _yellowOrange;
  static const formFieldProfileErrorIBorder = _red;
  static const formFieldFocusIBorder = _cloudBurst;
  static const formFieldHintText = _gray;
  static const formFieldTitle = _mineShaft;
  static const filterTitles = _mineShaft;
  static const formFieldBorder = _wildSand;

  /// toast ..
  static const toastBackground = _black;
  static const toastText = _white;

  /// paging
  static const paginationLoadingBackground = _white;

  /// bottom sheets
  static const modalBottomSheetBarrier = _black;
  static const modalBottomSheetDivider = _geyser;
  static const modalBottomSheetCloseIcon = _geyser;
  static const modalBottomSheetBackground = _aquaSpring;

  /// app navigation
  static const appNavigationIconColor = _white;
  static const bottomNavBarShadow = _black;
  static const bottomNavBarBackground = _black;

  /// auth
  static const divider = _dustyGray;
  static const continueWithOutLoginButtonBorder = _dustyGray;
  static const countryCode = _mineralGreen;
  static const countryCodeDivider = _doveGray;
  static const authHintText = _scorpion;
  static const authSigninBtnGradient1 = _brickRed;
  static const authSigninBtnGradient2 = _outrageousOrange;
  static const disabledButtonColor = _dustyGray;

  /// Otp
  static const otpSentText = _blackWith67Opacity;
  static const otpActiveFillColor = _concrete;
  static const otpSelectedFillColor = _white;
  static const otpInactiveFillColor = _white;
  static const otpInactiveBorderColor = _doveGray;
  static const otpActiveBorderColor = _white;
  static const otpSelectedBorderColor = _doveGray;
  static const otpFocusTextColor = _mineralGreen;
  static const dontReceiveOtpTxtColor = _scorpion;
  static const resendOtpTxtColor = _mineralGreen;
  static const otpBackIconColor = _doveGray;
  static const otpBoarder = _wildSand;

  /// Policy
  static const policyTxtBlackColor = _black;
  static const policyTxtWhiteColor = _white;
  static const policyDescriptionTxtColor = _blackWith67Opacity;

  /// User Info
  static const userInfoHintText = _blackWith67Opacity;
  static const userInfoButtonText = _white;
  static const userInfoEnabledText = _red;
  static const userInfoDisenabledText = _black;
  static const userInfoDialogBackground = _white;
  static const genderSelectedBorder = _outrageousOrange;
  static const genderUnSelectedBorder = _black;
  static const marriageTypeSelectedBackground = _concrete;
  static const marriageSelectedBorder = _outrageousOrange;
  static const marriageUnSelectedBorder = _black;
  static const skipBackgroundColor = _wildSand;
  static const talkAboutText = _blackWith67Opacity;
  static const talkAboutBtnText = _white;
  static const stepFourTitle = _black;
  static const sliderColor = _outrageousOrange;
  static const sliderThumbColor = _thunderbird;

  /// Home
  static const homeBackgroundGradient1 = _outrageousOrange;
  static const homeBackgroundGradient2 = _coffeeBean2;
  static const homeBackgroundGradient3 = _coffeeBean;
  static const homeBackgroundGradient4 = _castro;
  static const homePersonalInfoCardGradient1 = _black;
  static const homePersonalInfoCardGradient2 = _radicalRed;
  static const homePersonalInfoCardGradient3 = _flamingo;
  static const userInfoCardBorder = _outrageousOrange;
  static const diamondCountColor = _mePink;
  static const onlineColor = _green;
  static const offlineColor = _grey;
  static const filterSelectedBorder = _outrageousOrange;
  static final filterNotSelectedBorder = _doveGray.withValues(alpha: 0.46);
  static final filterDropDown = _doveGray.withValues(alpha: 0.62);
  static final filterDropDownText = _white.withValues(alpha: 0.78);
  static final filterDropDownBackground = _doveGray;

  /// Chat
  static final chatScreenBorder = _alto.withValues(alpha: 0.34);
  static final messageBadgeColor = _outrageousOrange;
  static final chatWhiteText = _white;

  /// Subscription
  static final nasebakSubscriptionGradient1 = _newYorkPink;
  static final nasebakSubscriptionGradient2 = _white;
  static final vipSubscriptionGradient1 = _oceanGreen;
  static final vipSubscriptionGradient2 = _white;
  static final promoteProfileGradient1 = _fountainBlue;
  static final promoteProfileGradient2 = _white;
  static final diamondMembershipGradient1 = _roseBud;
  static final diamondMembershipGradient2 = _white;
  static final goldenMembershipGradient1 = _sweetCorn;
  static final goldenMembershipGradient2 = _white;
  static final silverMembershipGradient1 = _nobel;
  static final silverMembershipGradient2 = _white;

  static final diamondMembershipNameGradient1 = _white;
  static final diamondMembershipNameGradient2 = _roseBud;

  static final goldenMembershipNameGradient1 = _white;
  static final goldenMembershipNameGradient2 = _goldenGrass;

  static final silverMembershipNameGradient1 = _white;
  static final silverMembershipNameGradient2 = _silverChalice;

  static final categoryContainerBackground = _coffeeBean;
  static final categoryContainerBorder = _doveGray;

  static final membershipButtonColor1 = _corn;
  static final membershipButtonColor2 = _white;

  /// Payments
  static final invoiceDetailsTextBackground = _outrageousOrange.withValues(
    alpha: 0.18,
  );
  static final paymentScreenBorder = _doveGray;
  static final paymentScreenTextFieldsBackground = _white.withValues(
    alpha: 0.22,
  );

  /// vip membership
  static final vipMembershipBorder = _doveGray;
  static final vipDiamondCountText = _guardsmanRed;
  static final vipDiamondPriceBackgroundGradient1 = _outrageousOrange;
  static final vipDiamondPriceBackgroundGradient2 = _redBerry;
  static final vipDiamondPriceTextColor = _concrete;
}

///
/// All name colors according to https://chir.ag/projects/name-that-color
///   100% - FF
///   95% - F2
///   90% - E6
///   85% - D9
///   80% - CC
///   75% - BF
///   70% - B3
///   65% - A6
///   60% - 99
///   55% - 8C
///   50% - 80
///   45% - 73
///   40% - 66
///   35% - 59
///   30% - 4D
///   25% - 40
///   20% - 33
///   15% - 26
///   10% - 1A
///   5% - 0D
///   0% - 00
