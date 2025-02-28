import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasebak_app/features/home/model/home_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoCardWidget extends StatelessWidget {
  final HomeUiModel model;
  const UserInfoCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white.withValues(alpha: 0.08),
          border: Border.all(
            color: AppColors.userInfoCardBorder.withValues(alpha: 0.20),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildDetails(context),
            const SizedBox(height: 10),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      model.otherUserInfo.userImage == null
                          ? AssetImage(
                            AppAssetPaths.personalInfoDummyProfileImage,
                          )
                          : NetworkImage(model.otherUserInfo.userImage!)
                              as ImageProvider,
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: SvgPicture.asset(
                    AppAssetPaths.verifiedIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Text(
              model.otherUserInfo.firstName!,
              style: context.headlineSmall?.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              model.otherUserInfo.diamondCount.toString(),
              style: context.headlineSmall?.copyWith(
                color: AppColors.diamondCountColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset(AppAssetPaths.diamondIcon, width: 20),
          ],
        ),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color:
                    model.otherUserInfo.online!
                        ? AppColors.onlineColor
                        : AppColors.offlineColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              model.otherUserInfo.online!
                  ? context.translate(LocalizationKeys.online)
                  : context.translate(LocalizationKeys.offline),
              style: context.headlineSmall?.copyWith(
                color:
                    model.otherUserInfo.online!
                        ? AppColors.onlineColor
                        : AppColors.offlineColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _infoChip(
          context.translate(LocalizationKeys.age),
          "${model.otherUserInfo.age} ${context.translate(LocalizationKeys.ageYear)}",
        ),
        _infoChip(
          context.translate(LocalizationKeys.nationality),
          model.otherUserInfo.nationality,
        ),
        _infoChip(
          context.translate(LocalizationKeys.status),
          model.userInfo.martialStatus,
        ),
        _infoChip(
          context.translate(LocalizationKeys.position),
          model.userInfo.position,
        ),
        _infoChip(
          "${model.otherUserInfo.weight} ${context.translate(LocalizationKeys.kg)}",
        ),
        _infoChip(
          "${model.otherUserInfo.height} ${context.translate(LocalizationKeys.cm)}",
        ),
        _infoChip(model.otherUserInfo.skinColor!),
      ],
    );
  }

  Widget _infoChip(String label, [String? value]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        value ?? label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            model.userInfo.description!,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            SvgPicture.asset(
              AppAssetPaths.chattingIcon,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.81),
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(width: 5),
            Text(
              model.otherUserInfo.messageCount.toString(),
              style: context.headlineSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.81),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              AppAssetPaths.eyeIcon,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.81),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
