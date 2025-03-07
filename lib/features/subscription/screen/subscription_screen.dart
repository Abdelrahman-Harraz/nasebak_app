import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/policy/bloc/policy_bloc.dart';
import 'package:nasebak_app/features/subscription/bloc/subscription_bloc.dart';
import 'package:nasebak_app/features/subscription/bloc/subscription_repository.dart';
import 'package:nasebak_app/features/subscription/model/subscription_ui_model.dart';
import 'package:nasebak_app/features/subscription/widgets/subscription_countdown_widget.dart';
import 'package:nasebak_app/features/subscription/widgets/subscription_end_date_widget.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SubscriptionBloc(
            subscriptionRepository: SubscriptionRepository(),
          ),
      child: const SubscriptionScreenWithBloc(),
    );
  }
}

class SubscriptionScreenWithBloc extends BaseStatefulScreenWidget {
  const SubscriptionScreenWithBloc({super.key});

  @override
  BaseScreenState<SubscriptionScreenWithBloc> baseScreenCreateState() =>
      _SubscriptionScreenWithBlocState();
}

class _SubscriptionScreenWithBlocState
    extends BaseScreenState<SubscriptionScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getSubscriptionDataEvent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
        title: Center(
          child: Text(
            context.translate(LocalizationKeys.subscriptionManagement),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
      body: BlocListener<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is LoadingState) {
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
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        if (state is SubscriptionDataLoadedSuccessfullyState) {
          return _pageContent(state.subscriptionUiModel);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(SubscriptionUiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            _nasebakMembershipWidget(),
            SizedBox(height: 12),
            _vipMembershipWidget(),
            SizedBox(height: 12),
            _promoteProfileWidget(),
            SizedBox(height: 12),
            SubscriptionCountdownWidget(countdown: model),
            SizedBox(height: 12),
            SubscriptionEndDateWidget(endDate: model.endDate),
            SizedBox(height: 12),
            _editSubscriptionWidget(),
            SizedBox(height: 12),
            _cancelSubscriptionWidget(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _nasebakMembershipWidget() {
    return Container(
      width: double.infinity,
      height: 91,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColors.nasebakSubscriptionGradient1,
            AppColors.nasebakSubscriptionGradient1,
            AppColors.nasebakSubscriptionGradient2,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssetPaths.nasebakMembershipIcon),
            Text(
              context.translate(LocalizationKeys.nasebakMembership),
              style: context.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 21,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssetPaths.redArrowIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vipMembershipWidget() {
    return Container(
      width: double.infinity,
      height: 91,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColors.vipSubscriptionGradient1,
            AppColors.vipSubscriptionGradient1,
            AppColors.vipSubscriptionGradient2,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssetPaths.vipMembershipIcon),
            Text(
              context.translate(LocalizationKeys.vipMemberships),
              style: context.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 21,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssetPaths.greenArrowIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoteProfileWidget() {
    return Container(
      width: double.infinity,
      height: 91,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColors.promoteProfileGradient1,
            AppColors.promoteProfileGradient1,
            AppColors.promoteProfileGradient2,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssetPaths.campaignIcon),
            Text(
              context.translate(LocalizationKeys.promoteYourProfile),
              style: context.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssetPaths.blueArrowIcon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editSubscriptionWidget() {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.translate(LocalizationKeys.changeSubscription),
              style: context.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            SvgPicture.asset(AppAssetPaths.editSubscriptionIcon),
          ],
        ),
      ),
    );
  }

  Widget _cancelSubscriptionWidget() {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.translate(LocalizationKeys.cancelSubscription),
              style: context.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            SvgPicture.asset(AppAssetPaths.cancelSubscriptionIcon),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  SubscriptionBloc get currentBloc => context.read<SubscriptionBloc>();

  void _getSubscriptionDataEvent() {
    currentBloc.add(GetSubscriptionDataEvent());
  }

  void _openUpdateUserInfoScreen() {
    context.push(AppRouter.updateUserInfoScreen);
  }
}
