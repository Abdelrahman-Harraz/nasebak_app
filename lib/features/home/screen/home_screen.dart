import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/home/bloc/home_bloc.dart';
import 'package:nasebak_app/features/home/bloc/home_repository.dart';
import 'package:nasebak_app/features/home/model/home_ui_model.dart';
import 'package:nasebak_app/features/home/widget/personal_info_card_widget.dart';
import 'package:nasebak_app/features/home/widget/user_info_card_widget.dart';

import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/status_bar/statusbar_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(homeRepository: HomeRepository()),
      child: const HomeScreenWithBloc(),
    );
  }
}

class HomeScreenWithBloc extends BaseStatefulScreenWidget {
  const HomeScreenWithBloc({super.key});

  @override
  BaseScreenState<HomeScreenWithBloc> baseScreenCreateState() =>
      _HomeScreenWithBlocState();
}

class _HomeScreenWithBlocState extends BaseScreenState<HomeScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getAboutUsDataEvent);
    setStatusBarColor(color: Colors.transparent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is LoadedHomeDataSuccessfullyState) {
          return _pageContent(state.myProfile);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(HomeUiModel userInfo) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _homeHeaderRowWidget(),
          _personaInfoWidget(userInfo),
          _filterRow(),
          _userInfoWidget(userInfo),

          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _homeHeaderRowWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 33, right: 33, top: 50, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_headerIconsWidget(), _homeHeaderLogoWidget()],
      ),
    );
  }

  Widget _headerIconsWidget() {
    return Row(
      children: [
        GestureDetector(
          child: SvgPicture.asset(AppAssetPaths.heartIcon),
          onTap: () {},
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          child: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _homeHeaderLogoWidget() {
    return SvgPicture.asset(AppAssetPaths.nasebakLogo, width: 52, height: 52);
  }

  Widget _personaInfoWidget(HomeUiModel userInfo) {
    return PersonalInfoCardWidget(model: userInfo);
  }

  Widget _userInfoWidget(HomeUiModel userInfo) {
    return UserInfoCardWidget(model: userInfo);
  }

  Widget _filterRow() {
    //! finish it later
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Text(
            context.translate(LocalizationKeys.filter),
            style: context.headlineSmall?.copyWith(
              color: AppColors.policyTxtBlackColor,
              fontSize: 18,
            ),
          ),
          SvgPicture.asset(AppAssetPaths.femaleIcon),
          SizedBox(width: 10),
          SvgPicture.asset(AppAssetPaths.maleIcon),
          SvgPicture.asset(AppAssetPaths.searchIcon),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  HomeBloc get currentBloc => context.read<HomeBloc>();

  void _getAboutUsDataEvent() {
    currentBloc.add(GetHomeData());
  }
}
