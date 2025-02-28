import 'package:flutter/material.dart';
import 'package:nasebak_app/features/home/model/home_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class PersonalInfoCardWidget extends StatelessWidget {
  final HomeUiModel model;
  const PersonalInfoCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
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

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        model.userInfo.verified == true
            ? Positioned(
              top: 0,
              left: 0,
              child: Icon(Icons.verified, color: Colors.yellow, size: 24),
            )
            : const SizedBox(),

        Row(
          children: [
            SizedBox(
              child: CircleAvatar(
                radius: 25,
                backgroundImage:
                    model.userInfo.userImage == null
                        ? AssetImage(
                          AppAssetPaths.personalInfoDummyProfileImage,
                        )
                        : NetworkImage(model.userInfo.userImage!),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.userInfo.firstName ?? "اسم المستخدم",
                  style: context.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    model.userInfo.description ?? "نبذة عن المستخدم...",
                    style: context.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(
            context.translate(LocalizationKeys.nationality),
            model.userInfo.nationality,
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.age),
            "${model.userInfo.age ?? 0}",
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.status),
            model.userInfo.martialStatus,
            context,
          ),
          _infoItem(
            context.translate(LocalizationKeys.position),
            model.userInfo.position,
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
