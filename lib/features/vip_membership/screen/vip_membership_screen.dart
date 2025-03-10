import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/features/payment/screen/payment_screen.dart';
import 'package:nasebak_app/features/vip_membership/bloc/vip_membership_bloc.dart';
import 'package:nasebak_app/features/vip_membership/bloc/vip_membership_repository.dart';
import 'package:nasebak_app/features/vip_membership/model/vip_membership_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class VipMembershipScreen extends StatelessWidget {
  const VipMembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => VipMembershipBloc(
            vipMembershipRepository: VipMembershipRepository(),
          ),
      child: const VipMembershipScreenWithBloc(),
    );
  }
}

class VipMembershipScreenWithBloc extends BaseStatefulScreenWidget {
  const VipMembershipScreenWithBloc({super.key});

  @override
  BaseScreenState<VipMembershipScreenWithBloc> baseScreenCreateState() =>
      _VipMembershipScreenWithBlocState();
}

class _VipMembershipScreenWithBlocState
    extends BaseScreenState<VipMembershipScreenWithBloc> {
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
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.menuIcon),
          ),
        ],
      ),
      body: BlocListener<VipMembershipBloc, VipMembershipState>(
        listener: (context, state) {
          if (state is VipMembershipLoadingState) {
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
    return BlocBuilder<VipMembershipBloc, VipMembershipState>(
      builder: (context, state) {
        if (state is VipMembershipDataLoadedSuccessfullyState) {
          return _pageContent(state.vipMembershipUiModel);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(List<VipMembershipUiModel> model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 100),
          Text(
            '"${context.translate(LocalizationKeys.openNewWorldOfExclusiveFeaturesWithJewels)}"',
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Text(
            context.translate(
              LocalizationKeys.appInterfaceLayoutDependsOnJewelsCount,
            ),
            style: context.bodyLarge!.copyWith(
              color: Colors.white.withValues(alpha: 0.52),
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 174 / 166,
              ),
              itemCount: model.length,
              itemBuilder: (context, index) {
                return _buildMembershipCard(model[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard(VipMembershipUiModel membership) {
    return GestureDetector(
      onTap: () => _onMembershipSelected(membership),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetPaths.vipContainerBackground),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssetPaths.vipDiamondIcon),
                    SizedBox(width: 5),
                    Text(
                      membership.diamondCount,
                      style: context.bodyLarge!.copyWith(
                        color: AppColors.vipDiamondCountText,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(membership.diamondImageUrl),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.vipDiamondPriceBackgroundGradient1,
                    AppColors.vipDiamondPriceBackgroundGradient2,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "${membership.price} ${membership.currency}",
                  style: context.bodyLarge!.copyWith(
                    color: AppColors.vipDiamondPriceTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  VipMembershipBloc get currentBloc => context.read<VipMembershipBloc>();

  void _getVipMembershipDataEvent() {
    currentBloc.add(GetVipMembershipDataEvent());
  }

  void _onMembershipSelected(VipMembershipUiModel membership) {
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
}
