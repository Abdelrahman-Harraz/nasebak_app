import 'package:nasebak_app/features/widgets/app_buttons/common_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Color? color;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;
  final double? width;
  final Color? borderColor;
  final double? borderRadius;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.padding,
    this.shape,
    this.width,
    this.borderColor,
    this.borderRadius,
  });

  factory AppElevatedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color textColor = AppColors.buttonTextColor,
    Color? color,
    required String title,
    double? width,
    Color? borderColor,
  }) {
    return AppElevatedButton(
      key: key,
      padding: padding,
      color: color,
      width: width,
      borderColor: borderColor,
      label: labelTextWidget(title, textColor),
      onPressed: onPressed,
    );
  }

  factory AppElevatedButton.whiteWithTitle({
    Key? key,
    VoidCallback? onPressed,
    required String title,
    double? width,
    Color? borderColor,
  }) {
    return AppElevatedButton(
      key: key,
      label: labelTextWidget(title, AppColors.appButtonGreenText),
      color: AppColors.appButtonWhiteBackground,
      width: width,
      borderColor: borderColor ?? AppColors.appButtonBorder,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 24),
        gradient:
            onPressed != null
                ? LinearGradient(
                  colors: [
                    AppColors.authSigninBtnGradient1,
                    AppColors.authSigninBtnGradient1,
                    AppColors.authSigninBtnGradient2,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
                : LinearGradient(
                  colors: [
                    AppColors.disabledButtonColor,
                    AppColors.disabledButtonColor,
                  ],
                ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(width ?? 358, 51),
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 24),
                side: BorderSide(color: borderColor ?? Colors.transparent),
              ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}
