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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? AppColors.appNavigationSelectedIcon
                  : AppColors.appNavigationUnSelectedIcon,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style:
                    isSelected
                        ? textTheme.headlineMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )
                        : textTheme.labelSmall!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
