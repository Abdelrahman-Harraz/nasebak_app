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
  static const Color _jaffa = Color(0xFFF47B3D);
  static const Color _sherpaBlue = Color(0xFF004053);
  static const Color _alto = Color(0xffD9D9D9);
  static const Color _yellowOrange = Color(0xffFAAF40);
  static const Color _frenchGray = Color(0xffCFCFD0);
  static const Color _cloudBurst = Color(0xff183059);
  static const Color _silver = Color(0xffC4C4C4);
  static const Color _gray = Color(0xff898989);
  static const Color _mineShaft = Color(0xff2D2D2D);
  static const Color _dustyGray = Color(0xff9A9A9A);
  static const Color _cararra = Color(0xffF1F2EC);
  static const Color _jaggedIce = Color(0xffB9E8E0);
  static const Color _wildSand = Color(0xFFF5F5F5);
  static const Color _greenHaze = Color(0xff009444);
  static const Color _aquaSpring = Color(0xffECF9F6);
  static const Color _geyser = Color(0xffCBD6DE);
  static const Color _hintOfRed = Color(0xffF6F4F3);
  static const Color _bluish = Color(0xff276FBF);
  static const Color _nobel = Color(0xffB7B7B7);
  static const Color _alto2 = Color(0xffCECECE);
  static const Color _sinbad = Color(0xff9AD6CC);
  static const Color _amaranth = Color(0xffF03A47);
  static const Color _sherpaBlueWithOpacity = Color(0xE6004053);
  static const Color _provincialPink = Color(0xFFFEF4F4);
  static const Color _cinderell = Color(0xFFFDEBE2);
  static const Color _red2 = Color(0xffF90000);
  static const Color _aquaHaze = Color(0xFFEDF4F2);
  static const Color _porcelain = Color(0xffEEF2F2);
  static const Color _codGrayWithOp15 = Color(0x26090909);
  static const Color _codGrayWithOp90 = Color(0xE6090909);

  /// New
  static const Color _mineralGreen = Color(0xFF374C47);
  static const Color _doveGray = Color(0xFF707070);
  static const Color _scorpion = Color(0x61606060);
  static const Color _brickRed = Color(0xFFC52943);
  static const Color _outrageousOrange = Color(0xFFFF5C3D);
  static const Color _blackWith67Opacity = Color(0xAB000000);
  static const Color _concrete = Color(0xFFF2F2F2);

  /// app main theme ...
  static const colorSchemeSeed = _sherpaBlue;
  static const colorPrimary = _white;
  static const scaffoldBackground = _white;
  static const appBarBackground = _sherpaBlue;
  static const transparentColor = _transparent;
  static const buttonBackground = _sherpaBlue;
  static const verifyEmailText = _sherpaBlue;
  static const verifyEmailDescriptionText = _black;
  static const dropDownButtonColor = _black;
  static const titleColor = _white;
  static const containerColor = _white;
  static const buttonTextColor = _white;
  static const leadingButtonBackroundColor = _white;
  static const leadingButtonColor = _black;
  static const iconTheme = _jaffa;
  static const dotsIndicator = _jaffa;
  static const dotsIndicatorActive = _jaffa;
  static const floatActionBtnBackgroundColor = _sherpaBlue;
  static const tagGreenColor = _greenHaze;
  static const floatActionBtnforegroundColor = _white;
  static const bottomNavigationBarBackground = _white;
  static const appBarTextColor = _white;
  static const appBarIconColor = _white;
  static const expandedDropDownColor = _yellowOrange;
  static const dropDownText = _sherpaBlue;
  static const selectedNavBarItem = _sherpaBlue;
  static const unSelectedNavBarItem = _alto;
  static const logOutButtonColor = _red;
  static const redButtonColor = _red;
  static const appButtonGreenText = _greenHaze;
  static const appButtonWhiteBackground = _white;
  static const appButtonBorder = _white;
  static const banksCardBoarder = _wildSand;
  static const containerBorder = _cararra;
  static const dropDownBorder = _cararra;
  static const filterBorder = _alto2;
  static const filterIcon = _alto2;
  static const blackColor = _black;

  /// text colors
  static const headlineMedium = _sherpaBlue;
  static const bodySmall = _silver;
  static const titleSmall = _gray;
  static const bodyMedium = _jaffa;
  static const bodyLarge = _white;
  static const headlineSmall = _dustyGray;
  static const headlineLarge = _mineShaft;
  static const titleMedium = _black;
  static const labelSmall = _alto2;
  static const displaySmall = _amaranth;

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

  /// filter modal sheet
  static const filterUnitTypeUnselectedItemBackGround = _wildSand;
  static const filterUnitTypeSelectedItemBorder = _bluish;
  static const filterUnitTypeUnSelectedItemBorder = _wildSand;
  static const filterUnitTypeSelectedItemBackground = _white;
  static const filterUnitTypeItemTitle = _greenHaze;
  static const investmentTypeBorder = _hintOfRed;
  static const chooseInvestmentType = _bluish;
  static const notChooseInvestmentType = _alto;
  static const filterDropDownMenuBorder = _hintOfRed;
  static const filterDropDownMenuIcon = _geyser;
  static const filterDropDownMenuHintText = _geyser;
  static const filterResetAllButtonBackground = _alto;
  static const filterResetAllButtonText = _nobel;
  static const filterDropDownMenu = _white;

  /// association
  static const aboutAssociationItemBackground = _porcelain;
  static const strategicDirectionsItemBackground = _white;
  static const aboutAssociationBorder = _cararra;
  static const aboutAssociationItemBorder = _cararra;
  static const foundersItemBackground = _white;
  static const reportItemImageBackground = _jaggedIce;
  static const reportItemBackground = _white;
  static const directorImageBackground = _sinbad;
  static const directorItemBackground = _white;
  static const associationLicenseCertificateBackground = _white;
  static const volunteeringFormBackground = _white;
  static const councilMeetingLocationIcon = _silver;

  /// auth
  static const divider = _dustyGray;
  static const continueWithOutLoginButtonBorder = _dustyGray;
  static const countryCode = _mineralGreen;
  static const countryCodeDivider = _doveGray;
  static const authHintText = _scorpion;
  static const authSigninBtnGradient1 = _brickRed;
  static const authSigninBtnGradient2 = _outrageousOrange;

  /// Filter
  static const selectedTabBackgroundColor = _sherpaBlue;
  static const unSelectedTabBackgroundColor = _white;
  static const selectedFilterText = _white;
  static const unSelectedFilterText = _silver;
  static const unSelectedFilterBorder = _aquaHaze;

  /// app navigation
  static const appNavigationSelectedIcon = _sherpaBlue;
  static const appNavigationUnSelectedIcon = _alto2;
  static const bottomNavBarShadow = _black;

  /// more
  static const moreExpansionborder = _cararra;
  static const moreExpansionBackground = _white;
  static const expandedMoreExpansionIcon = _jaffa;
  static const notExpandedMoreExpansionIcon = _sherpaBlue;
  static const moreExpansionDivider = _cararra;

  /// Video gallery
  static const videoDialogBackground = _sherpaBlueWithOpacity;

  /// Media material
  static const pdfBackground = _provincialPink;
  static const pdfTitleBackground = _white;
  static const pdfBoarder = _gray;

  ///Image gallery
  static const imageContainer = _white;
  static const selectedImageBorder = _sherpaBlue;
  static const galleryDialogBackground = _sherpaBlueWithOpacity;

  /// Track Card
  static const trackCardTitle = _black;
  static const trackLikeIconBackground = _cinderell;
  static const trackLikeIcon = _jaffa;
  static final tracknasebakBackground = _sinbad.withOpacity(0.09);

  /// Track Details
  static const trackDescriptionBorder = _cararra;
  static const detailsIcon = _silver;
  static const trackContainer = _white;
  static const trackInActiveDots = _white;
  static const trackCommentBorder = _cararra;
  static const mapPolyLine = _red;

  /// Tracks Filter
  static const tractFilterBottomSheetIcon = _silver;
  static const tractFilterResetIcon = _alto2;

  /// News screen
  static const startGradient = _codGrayWithOp15;
  static const endGradient = _codGrayWithOp90;
  static const notLoggedInProfileImageBackground = _sherpaBlue;
  static const loginIcon = _sherpaBlue;

  /// settings
  static const customSettingsButtonBackground = _white;
  static const customSettingsButtonBorder = _cararra;
  static const customSettingButtonTrailingIcon = _sherpaBlue;
  static const switchSettingsBackground = _white;
  static const activatedSwitchSettings = _jaffa;

  /// delete account
  static const deleteButtonBackground = _red2;
  static const cancelButtonBorder = _alto2;

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

  /// Policy
  static const policyTxtBlackColor = _black;
  static const policyTxtWhiteColor = _white;
  static const policyDescriptionTxtColor = _blackWith67Opacity;
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
