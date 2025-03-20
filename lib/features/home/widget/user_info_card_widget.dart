import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/cached_network_image/app_cached_network_image.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class UserInfoCardWidget extends StatelessWidget {
  final UserInfoUiModel model;
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
            GestureDetector(
              onTap: () {
                context.push(
                  AppRouter.userInfoScreen,
                  extra: {
                    AppRouter.userInfoModelKey: model,
                    AppRouter.isCurrentUserKey: false,
                  },
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        model.userImage == null
                            ? AssetImage(
                              AppAssetPaths.personalInfoDummyProfileImage,
                            )
                            : AppCachedNetworkImage(imageUrl: model.userImage!)
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
            ),
            const SizedBox(width: 8),
            Text(
              model.firstName!,
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
              formatDiamondCount(model.diamondCount!),
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
                    model.online!
                        ? AppColors.onlineColor
                        : AppColors.offlineColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              model.online!
                  ? context.translate(LocalizationKeys.online)
                  : context.translate(LocalizationKeys.offline),
              style: context.headlineSmall?.copyWith(
                color:
                    model.online!
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
          "${model.age} ${context.translate(LocalizationKeys.ageYear)}",
        ),
        _infoChip(
          context.translate(LocalizationKeys.nationality),
          model.nationality,
        ),
        _infoChip(
          context.translate(LocalizationKeys.status),
          model.martialStatus,
        ),
        _infoChip(context.translate(LocalizationKeys.position), model.position),
        _infoChip("${model.weight} ${context.translate(LocalizationKeys.kg)}"),
        _infoChip("${model.height} ${context.translate(LocalizationKeys.cm)}"),
        _infoChip(model.skinColor!),
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
            model.description ?? "",
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
              model.messageCount.toString(),
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

  String formatDiamondCount(int count) {
    if (count >= 1000) {
      double result = count / 1000;

      if (result == result.roundToDouble()) {
        return '${result.round()}k';
      } else {
        return '${result.toStringAsFixed(1)}k';
      }
    }
    return count.toString();
  }
}
