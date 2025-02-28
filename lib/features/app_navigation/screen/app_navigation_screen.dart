import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/app_navigation/bloc/app_navigation_bloc.dart';
import 'package:nasebak_app/features/app_navigation/widgets/app_nav_item_widget.dart';
import 'package:nasebak_app/features/home/screen/home_screen.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({this.index, super.key});
  final int? index;

  static const appNavigationIndex = "appNavigationIndex";
  static const keyValue = "keyValue";

  static void open({required BuildContext context, int? index, Key? key}) {
    context.go(
      AppRouter.appNavigationScreen,
      extra: {appNavigationIndex: index, keyValue: key},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppNavigationBloc(),
      child: AppNavigationScreenWithBloc(index: index),
    );
  }
}

class AppNavigationScreenWithBloc extends BaseStatefulScreenWidget {
  const AppNavigationScreenWithBloc({this.index, super.key});
  final int? index;

  @override
  BaseScreenState<AppNavigationScreenWithBloc> baseScreenCreateState() =>
      _AppNavigationScreenWithBlocState();
}

class _AppNavigationScreenWithBlocState
    extends BaseScreenState<AppNavigationScreenWithBloc> {
  late int _selectedBottomNavigationIndex;

  final List<Widget> _appNavChildren = [
    const HomeScreen(),
    const _AppNavTempBodyWidget(screenName: "Track Recording"),
    const _AppNavTempBodyWidget(screenName: "Track Recording"),
    const _AppNavTempBodyWidget(screenName: "Track Recording"),
  ];

  @override
  void initState() {
    super.initState();
    _selectedBottomNavigationIndex = widget.index ?? 0;
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppNavigationBloc, AppNavigationState>(
        listener: (context, state) {
          if (state is SelectedBottomNavigationItemState) {
            _selectedBottomNavigationIndex = state.index;
          }
        },
        builder: (context, state) {
          return _appNavChildren[_selectedBottomNavigationIndex];
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetPaths.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildBottomNavigationBarWidget(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBottomNavigationBarWidget() {
    return BlocBuilder<AppNavigationBloc, AppNavigationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 9),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(28.r)),
            child: BottomNavigationBar(
              items: [
                _createBottomNavigationItem(
                  icon: AppAssetPaths.homeNavIcon,
                  label: LocalizationKeys.home,
                  isSelected: _selectedBottomNavigationIndex == 0,
                ),
                _createBottomNavigationItem(
                  icon: AppAssetPaths.chatNavIcon,
                  label: LocalizationKeys.chat,
                  isSelected: _selectedBottomNavigationIndex == 1,
                ),
                _createBottomNavigationItem(
                  icon: AppAssetPaths.membershipNavIcon,
                  label: LocalizationKeys.membership,
                  isSelected: _selectedBottomNavigationIndex == 2,
                ),
                _createBottomNavigationItem(
                  icon: AppAssetPaths.settingNavIcon,
                  label: LocalizationKeys.settings,
                  isSelected: _selectedBottomNavigationIndex == 3,
                ),
              ],
              currentIndex: _selectedBottomNavigationIndex,
              type: BottomNavigationBarType.shifting,

              onTap: _selectBottomNavigationItemEvent,
              selectedLabelStyle: textTheme.headlineMedium!.copyWith(
                fontSize: 0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: textTheme.labelSmall!.copyWith(
                fontSize: 0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _createBottomNavigationItem({
    required String icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: AppNavItemWidget(
        isSelected: isSelected,
        icon: icon,
        label: context.translate(label),
      ),
      backgroundColor: AppColors.bottomNavBarBackground,

      label: '',
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  AppNavigationBloc get currentBloc => context.read<AppNavigationBloc>();

  void _selectBottomNavigationItemEvent(index) {
    currentBloc.add(SelectBottomNavigationItemEvent(index: index));
  }
}

//TODO: This widget is temporary, remove it after finish development
class _AppNavTempBodyWidget extends StatelessWidget {
  const _AppNavTempBodyWidget({required this.screenName});

  final String screenName;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$screenName Under Development",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
