import 'package:flutter/material.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpWidget extends StatelessWidget {
  final void Function(String value) onCodeCompleted;
  final Color backgroundColor;
  final Color focusTextColor;
  final double? radius;

  const OtpWidget({
    required this.onCodeCompleted,
    this.backgroundColor = AppColors.blackColor,
    this.focusTextColor = AppColors.otpFocusTextColor,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              keyboardType: TextInputType.number,
              appContext: context,
              length: 5,
              showCursor: false,
              mainAxisAlignment: MainAxisAlignment.center,
              enableActiveFill: true,

              textStyle: TextStyle(color: AppColors.otpFocusTextColor),
              pinTheme: PinTheme(
                fieldOuterPadding: const EdgeInsetsDirectional.only(end: 14),
                borderRadius: BorderRadius.circular(radius ?? 6),
                fieldWidth: 50,
                fieldHeight: 50,

                /// Fill Colors
                activeFillColor: AppColors.otpActiveFillColor,
                selectedFillColor: AppColors.otpSelectedFillColor,
                inactiveFillColor: AppColors.otpInactiveFillColor,

                /// Borders Color
                inactiveColor: AppColors.otpInactiveBorderColor,
                activeColor: AppColors.otpActiveBorderColor,
                disabledColor: backgroundColor,
                selectedColor: AppColors.otpSelectedBorderColor,

                /// Border Width
                disabledBorderWidth: 0,
                selectedBorderWidth: 1.5,
                inactiveBorderWidth: 0,
                errorBorderWidth: 0,
                activeBorderWidth: 1.5,

                /// Border Colors
                errorBorderColor: Colors.red,

                shape: PinCodeFieldShape.box,
              ),
              onCompleted: onCodeCompleted,
              animationType: AnimationType.fade,
              animationDuration: const Duration(milliseconds: 200),
            ),
          ),
        ),
      ],
    );
  }
}
