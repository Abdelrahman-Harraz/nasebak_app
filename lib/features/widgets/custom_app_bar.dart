import 'package:badges/badges.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends AppBar {
  final String? tittle;
  final int inCartCounter;
  final VoidCallback? notificationIconClickedCallBack;
  final List<Widget>? listOfActions;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final bool? titleCenter;

  CustomAppBar({
    this.tittle,
    this.listOfActions,
    this.notificationIconClickedCallBack,
    this.inCartCounter = 0,
    this.titleWidget,
    this.leadingWidget,
    this.titleCenter,
    super.key,
  });

  @override
  Widget? get leading => leadingWidget ?? super.leading;
  @override
  Widget? get title => titleWidget ?? Text(tittle!);
  @override
  bool? get centerTitle => titleCenter ?? false;

  @override
  List<Widget>? get actions =>
      listOfActions ??
      [
        IconButton(
          icon: badges.Badge(
            showBadge: (inCartCounter > 0) ? true : false,
            badgeStyle: const BadgeStyle(
              badgeColor: AppColors.appBarBackground,
            ),
            badgeContent: Text(
              "$inCartCounter",
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.appBarTextColor,
              ),
            ),
            position: BadgePosition.topEnd(top: -10, end: -10),
            child: const Icon(Icons.notifications),
          ),
          onPressed: notificationIconClickedCallBack,
        ),
        const SizedBox(width: 20),
      ];
  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
  );
}

class CustomWidgetToAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget child;
  const CustomWidgetToAppBar({super.key, required this.child});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
