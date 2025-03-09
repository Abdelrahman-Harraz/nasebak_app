import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/features/membership/model/membership_ui_model.dart';
import 'package:nasebak_app/features/payment/screen/payment_screen.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class MembershipDetailsScreen extends StatelessWidget {
  final MembershipUiModel subscription;

  const MembershipDetailsScreen({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.menuIcon),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 100),
                _buildSubscriptionCard(context, subscription),
                SizedBox(height: 30),
                _buildFeatureList(context, subscription),
                SizedBox(height: 20),
                _buildSubscribeButton(context, subscription),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildSubscriptionCard(
    BuildContext context,
    MembershipUiModel subscription,
  ) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient:
            subscription.isGold == true
                ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.goldenMembershipGradient1,
                    AppColors.goldenMembershipGradient2,
                  ],
                )
                : subscription.isDiamond == true
                ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.diamondMembershipGradient1,
                    AppColors.diamondMembershipGradient2,
                  ],
                )
                : subscription.isSilver == true
                ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.silverMembershipGradient1,
                    AppColors.silverMembershipGradient2,
                  ],
                )
                : null,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(subscription.imageUrl),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                gradient:
                    subscription.isGold == true
                        ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.goldenMembershipNameGradient1,
                            AppColors.goldenMembershipNameGradient2,
                          ],
                        )
                        : subscription.isDiamond == true
                        ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.diamondMembershipNameGradient1,
                            AppColors.diamondMembershipNameGradient2,
                          ],
                        )
                        : subscription.isSilver == true
                        ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.silverMembershipNameGradient1,
                            AppColors.silverMembershipNameGradient2,
                          ],
                        )
                        : null,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  subscription.name,
                  style: context.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subscription.duration.toString(),
                  style: context.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subscription.dateValue,
                  style: context.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList(
    BuildContext context,
    MembershipUiModel subscription,
  ) {
    return Column(
      children:
          subscription.features.map((feature) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.categoryContainerBorder,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 100),
                            Text(
                              context.translate(LocalizationKeys.free),
                              style: context.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              context.translate(LocalizationKeys.golden),
                              style: context.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ...feature.items.map((item) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          item.isAvailable
                                              ? AppAssetPaths.tickIcon
                                              : AppAssetPaths.notAvailableIcon,
                                        ),
                                        SizedBox(width: 70),
                                        SvgPicture.asset(
                                          item.isAvailable
                                              ? AppAssetPaths.notAvailableIcon
                                              : AppAssetPaths.tickIcon,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.categoryContainerBackground,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.categoryContainerBorder,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          feature.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSubscribeButton(
    BuildContext context,
    MembershipUiModel subscription,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.membershipButtonColor2,
            AppColors.membershipButtonColor1,
            AppColors.membershipButtonColor1,
            AppColors.membershipButtonColor1,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentScreen(subscription: subscription),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "${subscription.price} ${subscription.currency}",
            style: context.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
        ),
      ),
    );
  }
}
