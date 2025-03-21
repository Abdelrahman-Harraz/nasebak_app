import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/managers/setting_api_manager.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/setting/bloc/setting_bloc.dart';
import 'package:nasebak_app/features/setting/bloc/setting_repository.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SettingBloc(
            settingRepository: SettingRepository(
              settingApiManager: SettingApiManager(GetIt.I<DioApiManager>()),
              preferencesManager: GetIt.I<PreferencesManager>(),
            ),
          ),
      child: const MembershipScreenWithBloc(),
    );
  }
}

class MembershipScreenWithBloc extends BaseStatefulScreenWidget {
  const MembershipScreenWithBloc({super.key});

  @override
  BaseScreenState<MembershipScreenWithBloc> baseScreenCreateState() =>
      _MembershipScreenWithBlocState();
}

class _MembershipScreenWithBlocState
    extends BaseScreenState<MembershipScreenWithBloc> {
  double _ageValue = 0;
  double _weightValue = 0;
  double _heightValue = 0;
  @override
  void initState() {
    super.initState();

    Future.microtask(_getSettingsDataEvent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
        centerTitle: true,
        title: Text(context.translate(LocalizationKeys.settings)),
        actions: [
          IconButton(
            onPressed: _openNotificationsScreen,
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
      body: BlocListener<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state is SettingLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetPaths.homeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildPageContent(),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildPageContent() {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is LoadedMyProfileSuccessfullyState) {
          return _pageContent(state.myProfile);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(UserInfoUiModel model) {
    _ageValue = model.age?.toDouble() ?? 0;
    _weightValue = model.weight?.toDouble() ?? 0;
    _heightValue = model.height?.toDouble() ?? 0;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          children: [
            SizedBox(height: 100),
            _buildProfileHeader(model),
            SizedBox(height: 8),
            _buildPersonalInformation(model),
            SizedBox(height: 11),
            ElevatedButton(
              onPressed: () {
                _showDeleteAccountDialog(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.deleteAccountBtn,
              ),
              child: Text(
                context.translate(LocalizationKeys.deleteAccount),
                style: context.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 11),
            ElevatedButton(
              onPressed: _logOutClicked,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.logOutBtn,
              ),
              child: Text(
                context.translate(LocalizationKeys.logout),
                style: context.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserInfoUiModel model) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.userInfoContainerBackground,
            border: Border.all(
              color: AppColors.userInfoCardBorder.withValues(alpha: 0.20),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildProfileImage(model),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(UserInfoUiModel model) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 72,
          width: 72,
          child: CircleAvatar(
            radius: 60,
            backgroundImage:
                model.userImage == null || model.userImage!.isEmpty
                    ? AssetImage(AppAssetPaths.personalInfoDummyProfileImage)
                    : FileImage(File(model.userImage!)),
          ),
        ),
        if (model.verified == true)
          Positioned(
            top: 0,
            right: -10,
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(AppAssetPaths.editIcon, width: 30, height: 30),
            ),
          ),
      ],
    );
  }

  Widget _buildPersonalInformation(UserInfoUiModel model) {
    return _buildInfoSection([
      _buildInfoRow(
        context.translate(LocalizationKeys.mobileNumber),
        model.mobileNumber,
        context,
        AppAssetPaths.phoneIcon,
      ),
      _buildAgeSlider(context, model),
      _buildWeightSlider(context, model),
      _buildHeightSlider(context, model),
      _buildIncomeSlider(context, model),
      // _buildInfoRow(
      //   context.translate(LocalizationKeys.income),
      //   "${model.income!.end.toString()} ${context.translate(LocalizationKeys.sar)}",
      //   context,
      //   "",
      // ),
      _buildInfoRow(
        context.translate(LocalizationKeys.whatAreYouLookingFor),
        model.marriageType,
        context,
        AppAssetPaths.lensIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouDrink),
        model.drinkingHabit!,
        context,
        AppAssetPaths.cupIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.smokeCount),
        model.smokingHabit!,
        context,
        AppAssetPaths.smokeIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.exerciseCount),
        model.exerciseFrequency!,
        context,
        AppAssetPaths.gymIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.havePets),
        model.pets!.join(", "),
        context,
        AppAssetPaths.pawIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.education),
        model.education!,
        context,
        AppAssetPaths.educationIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.consistency),
        model.islam!,
        context,
        AppAssetPaths.masjidIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.perspective),
        model.perspective!,
        context,
        AppAssetPaths.smileIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.nationality),
        model.nationality!,
        context,
        AppAssetPaths.nationalityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.countryOfResidence),
        model.countryOfResidence!,
        context,
        AppAssetPaths.countryIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.city),
        model.city!,
        context,
        AppAssetPaths.cityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.skin),
        model.skinColor!,
        context,
        AppAssetPaths.skinIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.tribe),
        model.tribe!,
        context,
        AppAssetPaths.tribeIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouAcceptNationality),
        model.acceptNationality! ? "نعم" : "لا",
        context,
        AppAssetPaths.acceptNationalityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.maritalStatus),
        model.martialStatus!,
        context,
        AppAssetPaths.ringIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.haveKids),
        model.kids!,
        context,
        AppAssetPaths.babyCarIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.look),
        model.look!,
        context,
        AppAssetPaths.faceIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.hair),
        model.hair!,
        context,
        AppAssetPaths.hairIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.health),
        model.health!,
        context,
        AppAssetPaths.bedIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouHaveAnyCondition),
        model.conditions!,
        context,
        AppAssetPaths.rulesIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.describeYourSelf),
        model.description!,
        context,
        AppAssetPaths.penIcon,
      ),
    ]);
  }

  Widget _buildInfoSection(List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...rows],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    BuildContext context,
    String? icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.userInfoContainerBackground,
          border: Border.all(
            color: AppColors.userInfoCardBorder.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon?.isNotEmpty ?? false) ...[
                    SvgPicture.asset(
                      icon!,
                      width: 21,
                      height: 21,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withValues(alpha: 0.43),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 9),
                  ],
                  Expanded(
                    child: Text(
                      label,
                      style: context.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                value,
                style: context.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeSlider(BuildContext context, UserInfoUiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.userInfoContainerBackground,
          border: Border.all(
            color: AppColors.userInfoCardBorder.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssetPaths.ageIcon,
                      width: 21,
                      height: 21,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withValues(alpha: 0.43),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      context.translate(LocalizationKeys.age),
                      style: context.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${_ageValue.round()} ${context.translate(LocalizationKeys.year)}",
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Theme(
              data: ThemeData(
                sliderTheme: SliderThemeData(
                  thumbColor: AppColors.sliderThumbColor,
                  thumbSize: WidgetStateProperty.all(Size(3, 3)),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
              ),
              child: Slider(
                value: _ageValue,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: AppColors.sliderColor,
                inactiveColor: AppColors.sliderIActiveColor,
                label: _ageValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _ageValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightSlider(BuildContext context, UserInfoUiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.userInfoContainerBackground,
          border: Border.all(
            color: AppColors.userInfoCardBorder.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssetPaths.weightIcon,
                      width: 21,
                      height: 21,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withValues(alpha: 0.43),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      context.translate(LocalizationKeys.weight),
                      style: context.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${_weightValue.round()} ${context.translate(LocalizationKeys.kg)}",
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Theme(
              data: ThemeData(
                sliderTheme: SliderThemeData(
                  thumbColor: AppColors.sliderThumbColor,
                  thumbSize: WidgetStateProperty.all(Size(3, 3)),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
              ),
              child: Slider(
                value: _ageValue,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: AppColors.sliderColor,
                inactiveColor: AppColors.sliderIActiveColor,
                label: _weightValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _weightValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightSlider(BuildContext context, UserInfoUiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.userInfoContainerBackground,
          border: Border.all(
            color: AppColors.userInfoCardBorder.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssetPaths.tallIcon,
                      width: 21,
                      height: 21,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withValues(alpha: 0.43),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      context.translate(LocalizationKeys.tall),
                      style: context.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${_heightValue.round()} ${context.translate(LocalizationKeys.cm)}",
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Theme(
              data: ThemeData(
                sliderTheme: SliderThemeData(
                  thumbColor: AppColors.sliderThumbColor,
                  thumbSize: WidgetStateProperty.all(Size(3, 3)),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
              ),
              child: Slider(
                value: _ageValue,
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: AppColors.sliderColor,
                inactiveColor: AppColors.sliderIActiveColor,
                label: _heightValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _heightValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeSlider(BuildContext context, UserInfoUiModel model) {
    RangeValues _incomeRange = model.income ?? RangeValues(0, 10000000);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.userInfoContainerBackground,
        border: Border.all(
          color: AppColors.userInfoCardBorder.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.translate(LocalizationKeys.income),
              style: context.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'من ${model.income!.start} ريال',
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              Text(
                'إلى ${model.income!.end} ريال',
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ],
          ),

          Theme(
            data: ThemeData(
              sliderTheme: SliderThemeData(
                thumbColor: AppColors.sliderThumbColor,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 15.0,
                ),
                overlayShape: SliderComponentShape.noOverlay,
              ),
            ),
            child: RangeSlider(
              values: _incomeRange,
              min: 0,
              max: 10000000,
              divisions: 100,
              labels: RangeLabels(
                "${_incomeRange.start.toInt()} ${context.translate(LocalizationKeys.sar)}",
                "${_incomeRange.end.toInt()} ${context.translate(LocalizationKeys.sar)}",
              ),
              activeColor: AppColors.sliderColor,
              inactiveColor: AppColors.sliderIActiveColor,
              onChanged: (RangeValues values) {
                setState(() {
                  _incomeRange = values;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  SettingBloc get currentBloc => context.read<SettingBloc>();

  void _getSettingsDataEvent() {
    currentBloc.add(GetProfileDataEvent());
  }

  Future<void> _pickImage(UserInfoUiModel model) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        model.userImage = image.path;
      });
      currentBloc.add(UploadProfileImageEvent(image.path));
    }
  }

  void _openNotificationsScreen() {
    context.push(AppRouter.notificationsScreen);
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.warningPopUpGradient1,
                  AppColors.warningPopUpGradient2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.translate(
                    LocalizationKeys.areYouSureYouWantToDeleteYourAccount,
                  ),
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                SvgPicture.asset(AppAssetPaths.warningIcon),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _logOutClicked,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 37),
                        backgroundColor: AppColors.yesBtn,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        context.translate(LocalizationKeys.yes),
                        style: context.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 37),
                        backgroundColor: AppColors.noBtn,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        context.translate(LocalizationKeys.no),
                        style: context.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _logOutClicked() {
    context.pushReplacement(AppRouter.phoneRegistrationScreen);
  }
}
