import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class GoldenMembershipUserCardWidget extends StatelessWidget {
  final UserInfoUiModel model;
  const GoldenMembershipUserCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRouter.userInfoScreen,
          extra: {
            AppRouter.userInfoModelKey: model,
            AppRouter.isCurrentUserKey: true,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.homePersonalInfoCardGradient1,
              AppColors.homePersonalInfoCardGradient2,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssetPaths.personalInfoBackground,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 12),
                  _buildDetails(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Icon(Icons.verified, color: Colors.yellow, size: 24),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    model.userImage == null
                        ? AssetImage(
                          AppAssetPaths.personalInfoDummyProfileImage,
                        )
                        : NetworkImage(model.userImage!),
              ),
              const SizedBox(width: 10),
              Expanded(
                // Use Expanded to constrain the text
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.firstName ?? "اسم المستخدم",
                      style: context.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      model.description ?? "نبذة عن المستخدم...",
                      style: context.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(
            context.translate(LocalizationKeys.nationality),
            model.nationality,
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.age),
            "${model.age}",
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.status),
            model.martialStatus,
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.position),
            model.position,
            context,
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String title, String? value, BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.headlineSmall?.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        Text(
          value ?? context.translate(LocalizationKeys.undefined),
          style: context.headlineSmall?.copyWith(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
