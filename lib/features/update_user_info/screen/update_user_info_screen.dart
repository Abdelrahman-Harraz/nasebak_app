import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/features/update_user_info/bloc/update_user_info_bloc.dart';
import 'package:nasebak_app/features/update_user_info/bloc/update_user_info_repository.dart';
import 'package:nasebak_app/features/update_user_info/widget/about_your_self_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/gender_selection_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/marriage_selection_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/user_info_step_five_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/user_info_step_four_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/user_info_step_seven_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/user_info_step_six_widget.dart';
import 'package:nasebak_app/features/update_user_info/widget/user_info_step_three_widget.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/feedback/feedback_message.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/status_bar/statusbar_controller.dart';
import 'package:nasebak_app/utils/validations/app_validate.dart';

class UpdateUserInfoScreen extends StatelessWidget {
  const UpdateUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => UpdateUserInfoBloc(
            updateUserInfoRepository: UpdateUserInfoRepository(),
          ),
      child: const UpdateUserInfoScreenWithBloc(),
    );
  }
}

class UpdateUserInfoScreenWithBloc extends BaseStatefulScreenWidget {
  const UpdateUserInfoScreenWithBloc({super.key});

  @override
  BaseScreenState<UpdateUserInfoScreenWithBloc> baseScreenCreateState() =>
      _UpdateUserInfoScreenWithBlocState();
}

class _UpdateUserInfoScreenWithBlocState
    extends BaseScreenState<UpdateUserInfoScreenWithBloc>
    with AppValidate {
  UserInfoUiModel? userInfoUiModel;
  late UserInfoUiModel oldUserInfoUiModel;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController firstNameTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  final PageController _pageController = PageController(initialPage: 0);
  int? selectedGenderId;
  int? selectedMarriageId;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    firstNameTextEditingController.addListener(() {
      setState(() {
        isButtonEnabled = firstNameTextEditingController.text.trim().isNotEmpty;
      });
    });
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    Future.microtask(() => _getProfileDataEvent());
    setStatusBarColor(color: AppColors.transparentColor);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is LoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is ErrorState) {
            showFeedbackMessage(
              state.isLocalizationKey
                  ? context.translate(state.errorMessage)
                  : state.errorMessage,
            );
          } else if (state is EditUserInfoLoadedState) {
            _changeOldUserData(state.userInfoUiModel);
            userInfoUiModel = state.userInfoUiModel;

            if (state.userInfoUiModel.firstName?.isNotEmpty ?? false) {
              firstNameTextEditingController.text =
                  state.userInfoUiModel.firstName!;
            }
          } else if (state is UpdateUserInfoNotValidatedState) {
            autovalidateMode = AutovalidateMode.always;
            showFeedbackMessage(context.translate(LocalizationKeys.required));
          } else if (state is UpdateUserInfoValidatedState) {
            _checkNewProfileData();
          } else if (state is MustChangeUserInfoState) {
            showFeedbackMessage(context.translate(LocalizationKeys.noData));
          } else if (state is UserInfoCanUpdateState) {
            _changeProfileData();
          }
        },
        child: BlocBuilder<UpdateUserInfoBloc, UpdateUserInfoState>(
          builder: (context, state) {
            if (userInfoUiModel != null) {
              return PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildEditProfileForm(userInfoUiModel!),
                  _buildGenderSelectionPage(),
                  _marriageTypeSelectionPage(),
                  _aboutYourSelfWidget(),
                  _userInfoStepThreeWidget(),
                  _userInfoStepFourWidget(),
                  _userInfoStepFiveWidget(),
                  _userInfoStepSixWidget(),
                  _userInfoStepSevenWidget(),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
        onTap: () {
          if (_currentPage > 0) {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            _backClicked();
          }
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.otpBackIconColor,
          size: 41,
        ),
      ),

      actions:
          _currentPage >= 3
              ? [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 99,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.skipBackgroundColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Center(
                        child: Text(context.translate(LocalizationKeys.skip)),
                      ),
                    ),
                  ),
                ),
              ]
              : null,
    );
  }

  Widget _buildEditProfileForm(UserInfoUiModel model) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: userInfoFormKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 52),
                        child: Text(
                          context.translate(
                            LocalizationKeys.whatsYourFirstName,
                          ),
                          style: context.titleMedium!.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _textFormField(),
                      SizedBox(height: 20.h),
                      _bottomText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Button at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 53, horizontal: 36),
            child: _buttonWidgets(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelectionPage() {
    return GenderSelectionWidget(
      onGenderSelected: (int? id) {
        setState(() {
          selectedGenderId = id;
        });
      },
      selectedGenderId: selectedGenderId,
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _marriageTypeSelectionPage() {
    return MarriageSelectionWidget(
      selectedMarriageId: selectedMarriageId,
      onMarriageSelected: (int? id) {
        setState(() {
          selectedMarriageId = id;
        });
      },
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _aboutYourSelfWidget() {
    return AboutYourSelfWidget(
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _userInfoStepThreeWidget() {
    return UserInfoStepThreeWidget(
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _userInfoStepFourWidget() {
    return UserInfoStepFourWidget(
      userName:
          ("${firstNameTextEditingController.text}, ${context.translate(LocalizationKeys.letsTalkAboutLife)}"),
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _userInfoStepFiveWidget() {
    return UserInfoStepFiveWidget(
      userName:
          ("${firstNameTextEditingController.text}, ${context.translate(LocalizationKeys.truthContinue)}"),
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _userInfoStepSixWidget() {
    return UserInfoStepSixWidget(
      onNextPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _userInfoStepSevenWidget() {
    return UserInfoStepSevenWidget(
      onNextPressed: () {
        _showNextDialog();
      },
    );
  }

  Widget _bottomText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          child: Text(
            context.translate(LocalizationKeys.theNameWillAppearInYourProfile),
            style: context.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 57),
          child: Text(
            context.translate(LocalizationKeys.cantChangeInFuture),
            style: context.titleMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  isButtonEnabled
                      ? AppColors.userInfoEnabledText
                      : AppColors.userInfoDisenabledText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: TextFormField(
        cursorColor: Colors.black,

        controller: firstNameTextEditingController,

        style: context.titleMedium!.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: context.translate(LocalizationKeys.enterYourFirstName),
          hintStyle: context.titleMedium!.copyWith(
            fontSize: 18,
            color: AppColors.userInfoHintText,
          ),
        ),
        validator: (value) => fullNameValidator(context, value),
        onSaved: _firstNameSaved,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.go,
      ),
    );
  }

  Widget _buttonWidgets() {
    return AppElevatedButton(
      color: Colors.black,
      onPressed: isButtonEnabled ? _saveChangeProfileClicked : null,
      label: Text(
        context.translate(LocalizationKeys.next),
        style: context.titleMedium!.copyWith(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: AppColors.userInfoButtonText,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  UpdateUserInfoBloc get _currentBloc => context.read<UpdateUserInfoBloc>();

  void _firstNameSaved(String? value) {
    userInfoUiModel?.firstName = value!;
  }

  void _getProfileDataEvent() {
    _currentBloc.add(GetEditUserInfoEvent());
  }

  void _checkNewProfileData() {
    _currentBloc.add(
      CheckNewUserInfoEvent(oldUserInfoUiModel, userInfoUiModel!),
    );
  }

  void _changeProfileData() {
    _currentBloc.add(SaveUserInfoChangeApiEvent(userInfoUiModel!));
  }

  void _saveChangeProfileClicked() {
    _currentBloc.add(ValidateEditUserInfoEvent(userInfoFormKey));
    if (userInfoFormKey.currentState?.validate() ?? false) {
      _showNameDialog();
    }
  }

  void _backClicked() {
    Navigator.of(context).pop();
  }

  void _changeOldUserData(UserInfoUiModel userInfoUiModel) {
    oldUserInfoUiModel = UserInfoUiModel(
      id: userInfoUiModel.id,
      firstName: userInfoUiModel.firstName,
      gender: userInfoUiModel.gender,
      marriageType: userInfoUiModel.marriageType,
    );
  }

  void _showNameDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: AppColors.userInfoDialogBackground,
            content: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Image.asset(AppAssetPaths.alertStartImage),
                Center(
                  child: Text(
                    "${context.translate(LocalizationKeys.hi)}, ${firstNameTextEditingController.text}",
                    style: context.titleMedium!.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Text(
                  context.translate(LocalizationKeys.letsContinueYourProfile),
                  style: context.titleMedium!.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: AppElevatedButton(
                  width: 194,
                  onPressed: () {
                    Navigator.pop(context);
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  label: Text(context.translate(LocalizationKeys.letsStart)),
                ),
              ),
            ],
          ),
    );
  }

  void _showNextDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: AppColors.userInfoDialogBackground,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssetPaths.rocketIcon),
                SizedBox(height: 7),
                Center(
                  child: Text(
                    "${context.translate(LocalizationKeys.congratulations)}, ${firstNameTextEditingController.text}",
                    style: context.titleMedium!.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Text(
                  context.translate(LocalizationKeys.youCompleteYourProfile),
                  style: context.titleMedium!.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: AppElevatedButton(
                  width: 194,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text(
                    context.translate(LocalizationKeys.letsStart),
                    style: context.titleMedium!.copyWith(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
