import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/policy/bloc/policy_bloc.dart';
import 'package:nasebak_app/features/policy/bloc/policy_repository.dart';
import 'package:nasebak_app/features/policy/model/policy_ui_model.dart';
import 'package:nasebak_app/features/widgets/app_buttons/app_buttons.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PolicyBloc(policyRepository: PolicyRepository()),
      child: const PolicyScreenWithBloc(),
    );
  }
}

class PolicyScreenWithBloc extends BaseStatefulScreenWidget {
  const PolicyScreenWithBloc({super.key});

  @override
  BaseScreenState<PolicyScreenWithBloc> baseScreenCreateState() =>
      _PolicyScreenWithBlocState();
}

class _PolicyScreenWithBlocState extends BaseScreenState<PolicyScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getAboutUsDataEvent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: BlocListener<PolicyBloc, PolicyState>(
        listener: (context, state) {
          if (state is LoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
        },
        child: _buildPageContent(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildPageContent() {
    return BlocBuilder<PolicyBloc, PolicyState>(
      builder: (context, state) {
        if (state is LoadedPolicyDataSuccessfullyState) {
          return _pageContent(state.policyUiModel);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(List<PolicyUiModel> policyUiModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _policyHeaderLogoWidget(),
          _policyHeaderText(),
          SizedBox(height: 28.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var policy in policyUiModel) ...[
                  Text(
                    policy.title,
                    style: context.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.policyDescriptionTxtColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    policy.description,
                    style: context.headlineSmall?.copyWith(
                      color: AppColors.policyDescriptionTxtColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 53),
            child: Center(
              child: AppElevatedButton(
                onPressed: _openUpdateUserInfoScreen,
                label: Text(
                  context.translate(LocalizationKeys.iAgree),
                  style: context.headlineSmall?.copyWith(
                    color: AppColors.policyTxtWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _policyHeaderText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(LocalizationKeys.welcomeInNasebak),
            style: context.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.policyTxtBlackColor,
              fontSize: 33,
            ),
          ),
          Text(
            context.translate(LocalizationKeys.pleaseFollowTheRules),
            style: context.headlineSmall?.copyWith(
              color: AppColors.policyTxtBlackColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyHeaderLogoWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 50, bottom: 18),
      child: SvgPicture.asset(
        AppAssetPaths.nasebakLogo,
        width: 136,
        height: 152,
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  PolicyBloc get currentBloc => context.read<PolicyBloc>();

  void _getAboutUsDataEvent() {
    currentBloc.add(GetPolicyDataEvent());
  }

  void _openUpdateUserInfoScreen() {
    context.push(AppRouter.updateUserInfoScreen);
  }
}
