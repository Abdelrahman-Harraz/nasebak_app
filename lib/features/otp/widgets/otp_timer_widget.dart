import 'package:flutter/material.dart';
import 'package:nasebak_app/features/otp/widgets/otp_widget.dart';
import 'package:nasebak_app/features/otp/widgets/timer_widget.dart';

class OtpTimerWidget extends StatelessWidget {
  final void Function(String value) onCodeCompleted;
  final VoidCallback onResendClicked;
  final Color? backgroundColor;
  final Color? focusTextColor;
  final double? radius;
  final Color? btnTextColor;
  final Color? btnBackgroundColor;
  final Duration? countdownTimeToEnableResend;

  const OtpTimerWidget({
    required this.onCodeCompleted,
    required this.onResendClicked,
    this.backgroundColor,
    this.focusTextColor,
    this.radius,
    this.btnTextColor,
    this.btnBackgroundColor,
    this.countdownTimeToEnableResend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        OtpWidget(onCodeCompleted: onCodeCompleted, radius: radius),
        TimerWidget(
          onResendClicked: onResendClicked,
          countdownDurationToEnableResend: countdownTimeToEnableResend,
          txtColor: btnTextColor,
        ),
      ],
    );
  }
}
