import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_widget.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class TimerWidget extends BaseStatefulWidget {
  final void Function() onResendClicked;
  final Color? txtColor;
  final Duration? countdownDurationToEnableResend;

  const TimerWidget({
    required this.onResendClicked,
    this.txtColor = Colors.black38,
    this.countdownDurationToEnableResend,
    super.key,
  });

  @override
  BaseState<TimerWidget> baseCreateState() => _TimerWidgetState();
}

class _TimerWidgetState extends BaseState<TimerWidget> {
  Timer? _countdownTimer;
  late Duration timerDuration;
  bool enableResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: enableResend ? _handleBtnClick : null,
        style: _btnStyle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.translate(LocalizationKeys.iDidNotReceiveCode),
              style: TextStyle(color: AppColors.dontReceiveOtpTxtColor),
            ),
            const SizedBox(width: 5),
            enableResend
                ? Text(
                  context.translate(LocalizationKeys.resendOtp),
                  style: TextStyle(color: AppColors.resendOtpTxtColor),
                )
                : Text(
                  _durationText(),
                  style: TextStyle(color: AppColors.resendOtpTxtColor),
                ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  ButtonStyle _btnStyle() {
    return TextButton.styleFrom(
      foregroundColor: AppColors.bodyLarge,
      disabledForegroundColor: AppColors.bodyLarge.withOpacity(0.5),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  void _handleBtnClick() {
    widget.onResendClicked();
    _startTimer();
  }

  void _startTimer() {
    _resetTimer();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {
        _updateViewAndDuration();
      }),
    );
  }

  void _stopTimer() {
    setState(() => _countdownTimer?.cancel());
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      timerDuration = _countDownDuration();
      enableResend = false;
    });
  }

  void _updateViewAndDuration() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = timerDuration.inSeconds - reduceSecondsBy;
      if (seconds == 0) {
        _countdownTimer?.cancel();
        enableResend = true;
      }
      timerDuration = Duration(seconds: seconds);
    });
  }

  String _durationText() {
    if (timerDuration.inSeconds == 0) {
      return "";
    } else {
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = strDigits(timerDuration.inMinutes.remainder(60));
      final seconds = strDigits(timerDuration.inSeconds.remainder(60));
      return "($minutes:$seconds)";
    }
  }

  Duration _countDownDuration() =>
      widget.countdownDurationToEnableResend ?? const Duration(minutes: 3);
}
