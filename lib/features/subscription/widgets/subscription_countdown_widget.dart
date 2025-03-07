import 'package:flutter/material.dart';
import 'package:nasebak_app/features/subscription/model/subscription_ui_model.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class SubscriptionCountdownWidget extends StatefulWidget {
  final SubscriptionUiModel countdown;

  const SubscriptionCountdownWidget({super.key, required this.countdown});

  @override
  State<SubscriptionCountdownWidget> createState() =>
      _SubscriptionCountdownWidgetState();
}

class _SubscriptionCountdownWidgetState
    extends State<SubscriptionCountdownWidget> {
  @override
  void initState() {
    super.initState();
    widget.countdown.onUpdate = () {
      if (mounted) {
        setState(() {});
      }
    };
    widget.countdown.startTimer();
  }

  @override
  void dispose() {
    widget.countdown.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = widget.countdown.remainingTime;
    final days = remainingTime.inDays;
    final hours = remainingTime.inHours.remainder(24);
    final minutes = remainingTime.inMinutes.remainder(60);
    final seconds = remainingTime.inSeconds.remainder(60);

    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate(LocalizationKeys.subscriptionTimeRemaining),

                style: context.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildTimeBox("يوم", days),
                      _buildDivider(),
                      _buildTimeBox("ساعة", hours),
                      _buildDivider(),
                      _buildTimeBox("دقيقة", minutes),
                      _buildDivider(),
                      _buildTimeBox("ثانية", seconds),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            "${context.translate(LocalizationKeys.subscriptionType)} ${widget.countdown.subscriptionType}",
            style: context.bodyLarge!.copyWith(
              color: Colors.black,

              fontSize: 15,
            ),
          ),
          Text(
            "${context.translate(LocalizationKeys.bundleType)} ${widget.countdown.packageType}",
            style: context.bodyLarge!.copyWith(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: context.bodyLarge!.copyWith(color: Colors.black, fontSize: 18),
        ),
        Text(
          label,
          style: context.bodyLarge!.copyWith(color: Colors.black, fontSize: 9),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(width: 1, height: 30, color: Colors.black54),
    );
  }
}
