import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoScreen extends StatelessWidget {
  final UserInfoUiModel userInfo;

  const UserInfoScreen({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.translate(LocalizationKeys.myProfile),
          style: context.headlineMedium?.copyWith(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              _openNotificationsScreen(context);
            },
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetPaths.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: _pageContent(context),
      ),
    );
  }

  SingleChildScrollView _pageContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildPersonalInformation(context),
            const SizedBox(height: 24),
            // _buildAdditionalInformation(context),
            const SizedBox(height: 24),
            // if (!isCurrentUser) _buildActionButtons(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppAssetPaths.chattingIcon),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            userInfo.online!
                                ? AppColors.onlineColor
                                : AppColors.offlineColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userInfo.online!
                          ? context.translate(LocalizationKeys.online)
                          : context.translate(LocalizationKeys.offline),
                      style: context.bodyMedium?.copyWith(
                        color:
                            userInfo.online!
                                ? AppColors.onlineColor
                                : AppColors.offlineColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.diamondCount.toString(),
                style: context.headlineSmall?.copyWith(
                  color: AppColors.diamondCountColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Image.asset(AppAssetPaths.diamondIcon, width: 19),
            ],
          ),
        ),
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
                child: _buildProfileImage(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Profile image
        SizedBox(
          height: 72,
          width: 72,
          child: CircleAvatar(
            radius: 60,
            backgroundImage:
                userInfo.userImage == null
                    ? AssetImage(AppAssetPaths.personalInfoDummyProfileImage)
                    : NetworkImage(userInfo.userImage!),
          ),
        ),

        if (userInfo.verified == true)
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

  Widget _buildPersonalInformation(BuildContext context) {
    return _buildInfoSection([
      _buildInfoRow(
        context.translate(LocalizationKeys.age),
        "${userInfo.age ?? 0} ${context.translate(LocalizationKeys.year)}",
        context,
        AppAssetPaths.ageIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.weight),
        "${userInfo.weight.toString()} ${context.translate(LocalizationKeys.kg)}",
        context,
        AppAssetPaths.weightIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.tall),
        "${userInfo.martialStatus!}  ${context.translate(LocalizationKeys.cm)}",
        context,
        AppAssetPaths.tallIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.income),
        "${userInfo.income!.end.toString()} ${context.translate(LocalizationKeys.sar)}",
        context,
        "",
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.whatAreYouLookingFor),
        userInfo.marriageType,
        context,
        AppAssetPaths.lensIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouDrink),
        userInfo.drinkingHabit!,
        context,
        AppAssetPaths.cupIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.smokeCount),
        userInfo.smokingHabit!,
        context,
        AppAssetPaths.smokeIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.exerciseCount),
        userInfo.exerciseFrequency!,
        context,
        AppAssetPaths.gymIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.havePets),
        userInfo.pets!.join(", "),
        context,
        AppAssetPaths.pawIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.education),
        userInfo.education!,
        context,
        AppAssetPaths.educationIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.consistency),
        userInfo.islam!,
        context,
        AppAssetPaths.masjidIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.perspective),
        userInfo.perspective!,
        context,
        AppAssetPaths.smileIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.nationality),
        userInfo.nationality!,
        context,
        AppAssetPaths.nationalityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.countryOfResidence),
        userInfo.countryOfResidence!,
        context,
        AppAssetPaths.countryIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.city),
        userInfo.city!,
        context,
        AppAssetPaths.cityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.skin),
        userInfo.skinColor!,
        context,
        AppAssetPaths.skinIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.tribe),
        userInfo.tribe!,
        context,
        AppAssetPaths.tribeIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouAcceptNationality),
        userInfo.acceptNationality! ? "نعم" : "لا",
        context,
        AppAssetPaths.acceptNationalityIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.maritalStatus),
        userInfo.martialStatus!,
        context,
        AppAssetPaths.ringIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.haveKids),
        userInfo.kids!,
        context,
        AppAssetPaths.babyCarIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.look),
        userInfo.look!,
        context,
        AppAssetPaths.faceIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.hair),
        userInfo.hair!,
        context,
        AppAssetPaths.hairIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.health),
        userInfo.health!,
        context,
        AppAssetPaths.bedIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouHaveAnyCondition),
        userInfo.conditions!,
        context,
        AppAssetPaths.rulesIcon,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.describeYourSelf),
        userInfo.description!,
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

  void _openNotificationsScreen(BuildContext context) {
    context.push(AppRouter.notificationsScreen);
  }
}
