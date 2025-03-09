import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/features/membership/bloc/membership_bloc.dart';
import 'package:nasebak_app/features/membership/bloc/membership_repository.dart';
import 'package:nasebak_app/features/membership/model/membership_ui_model.dart';
import 'package:nasebak_app/features/membership/screen/membership_details_screen.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              MembershipBloc(membershipRepository: MembershipRepository()),
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
  int currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
    Future.microtask(_getMembershipDataEvent);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
      body: BlocListener<MembershipBloc, MembershipState>(
        listener: (context, state) {
          if (state is MembershipLoadingState) {
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
    return BlocBuilder<MembershipBloc, MembershipState>(
      builder: (context, state) {
        if (state is MembershipDataLoadedSuccessfullyState) {
          return _pageContent(state.model);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(List<MembershipUiModel> subscriptions) {
    // Safety check to ensure subscriptions has at least 3 items (for middle selection)
    if (subscriptions.isEmpty) {
      return const EmptyWidget();
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: subscriptions.length,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: currentIndex == index ? 1.0 : 0.7, // Dim non-current pages
          child: _buildSubscriptionPage(subscriptions[index]),
        );
      },
    );
  }

  Widget _buildSubscriptionPage(MembershipUiModel subscription) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            _buildSubscriptionCard(subscription),
            SizedBox(height: 30),
            _buildFeatureList(subscription),
            SizedBox(height: 20),
            _buildSubscribeButton(subscription),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(MembershipUiModel subscription) {
    return Container(
      height: 76,
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
            SizedBox(height: 10),
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
            SizedBox(height: 5),
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

  Widget _buildFeatureList(MembershipUiModel subscription) {
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

  Widget _buildSubscribeButton(MembershipUiModel subscription) {
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
          _navigateToSubscriptionDetail(subscription);
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

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  MembershipBloc get currentBloc => context.read<MembershipBloc>();

  void _getMembershipDataEvent() {
    currentBloc.add(GetMembershipDataEvent());
  }

  void _navigateToSubscriptionDetail(MembershipUiModel subscription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MembershipDetailsScreen(subscription: subscription),
      ),
    );
  }
}
