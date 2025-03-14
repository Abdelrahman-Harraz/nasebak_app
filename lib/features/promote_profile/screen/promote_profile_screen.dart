import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/payment/screen/payment_screen.dart';
import 'package:nasebak_app/features/promote_profile/bloc/promote_profile_bloc.dart';
import 'package:nasebak_app/features/promote_profile/bloc/promote_profile_repository.dart';
import 'package:nasebak_app/features/promote_profile/model/promote_profile_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class PromoteProfileScreen extends StatelessWidget {
  const PromoteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => PromoteProfileBloc(
            promoteProfileRepository: PromoteProfileRepository(),
          ),
      child: const PromoteProfileScreenWithBloc(),
    );
  }
}

class PromoteProfileScreenWithBloc extends BaseStatefulScreenWidget {
  const PromoteProfileScreenWithBloc({super.key});

  @override
  BaseScreenState<PromoteProfileScreenWithBloc> baseScreenCreateState() =>
      _PromoteProfileScreenWithBlocState();
}

class _PromoteProfileScreenWithBlocState
    extends BaseScreenState<PromoteProfileScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getVipMembershipDataEvent);
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
            onPressed: _openNotificationsScreen,
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.menuIcon),
          ),
        ],
      ),
      body: BlocListener<PromoteProfileBloc, PromoteProfileState>(
        listener: (context, state) {
          if (state is PromoteProfileLoadingState) {
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

  Widget _buildPageContent() {
    return BlocBuilder<PromoteProfileBloc, PromoteProfileState>(
      builder: (context, state) {
        if (state is PromoteProfileDataLoadedSuccessfullyState) {
          return _pageContent(state.promoteProfileUiModel);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(List<PromoteProfileUiModel> model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              '"${context.translate(LocalizationKeys.increaseChancesMessage)}"',
              style: context.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              '"${context.translate(LocalizationKeys.investInYourHappinessSubscribeNow)}"',
              style: context.bodyLarge!.copyWith(
                color: Colors.white.withValues(alpha: 0.52),
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 17),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.length,
              itemBuilder: (context, index) {
                final item = model[index];
                return _membershipCard(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _membershipCard(PromoteProfileUiModel model) {
    List<Color> gradientColors =
        [
          [
            AppColors.promoteProfileFirstContainerGradient1,
            AppColors.promoteProfileFirstContainerGradient2,
          ],
          [
            AppColors.promoteProfileSecondContainerGradient1,
            AppColors.promoteProfileSecondContainerGradient2,
          ],
          [
            AppColors.promoteProfileThirdContainerGradient1,
            AppColors.promoteProfileThirdContainerGradient2,
          ],
        ][model.id - 1];

    List<Color> iconContainerColors = [
      AppColors.promoteProfileFirstContainerIconBackground,
      AppColors.promoteProfileSecondContainerIconBackground,
      AppColors.promoteProfileThirdContainerIconBackground,
    ];

    Color iconBackgroundColor = iconContainerColors[model.id - 1];

    Widget iconWithCircle(String assetPath) {
      return Container(
        width: 26,
        height: 26,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: iconBackgroundColor,
        ),
        child: SvgPicture.asset(assetPath),
      );
    }

    List<Color> buttonColors = [
      AppColors.promoteProfileFirstContainerBtnBackground,
      AppColors.promoteProfileSecondContainerBtnBackground,
      AppColors.promoteProfileThirdContainerBtnBackground,
    ];

    Color buttonBackgroundColor = buttonColors[model.id - 1];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppAssetPaths.promoteIcon),
              const SizedBox(width: 8),
              Text(
                context.translate(LocalizationKeys.promoteYourProfile),
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              iconWithCircle(AppAssetPaths.timerIcon),
              const SizedBox(width: 5),
              Text(
                "${model.duration} ${model.dateValue}",
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              iconWithCircle(AppAssetPaths.eyePromoteIcon),
              const SizedBox(width: 5),
              Text(
                model.feature,
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  iconWithCircle(AppAssetPaths.cartIcon),
                  const SizedBox(width: 5),
                  Text(
                    "${model.price} ${model.currency}",
                    style: context.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => _onMembershipSelected(model),
                child: Text(
                  context.translate(LocalizationKeys.bookNow),
                  style: context.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PromoteProfileBloc get currentBloc => context.read<PromoteProfileBloc>();

  void _getVipMembershipDataEvent() {
    currentBloc.add(GetPromoteProfileDateEvent());
  }

  void _onMembershipSelected(PromoteProfileUiModel membership) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => PaymentScreen(
              price: membership.price,
              currency: membership.currency,
            ),
      ),
    );
  }

  void _openNotificationsScreen() {
    context.push(AppRouter.notificationsScreen);
  }
}
