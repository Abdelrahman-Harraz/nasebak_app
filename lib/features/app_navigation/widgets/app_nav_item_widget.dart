import 'package:nasebak_app/_base/widgets/base_stateless_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AppNavItemWidget extends BaseStatelessWidget {
  AppNavItemWidget({
    required this.isSelected,
    required this.icon,
    required this.label,
    super.key,
  });

  final bool isSelected;
  final String icon;
  final String label;

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 43,
        decoration:
            isSelected
                ? BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.authSigninBtnGradient1,

                      AppColors.authSigninBtnGradient2,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                )
                : null,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SvgPicture.asset(
                  height: 26,
                  width: 26,
                  icon,
                  colorFilter: ColorFilter.mode(
                    AppColors.appNavigationIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                if (isSelected) SizedBox(width: 6),
                if (isSelected)
                  Text(
                    label,
                    style: textTheme.headlineMedium!.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appNavigationIconColor,
                    ),
                    // overflow: TextOverflow.visible,
                    // maxLines: 1,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
