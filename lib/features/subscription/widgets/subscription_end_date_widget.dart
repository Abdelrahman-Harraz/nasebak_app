import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class SubscriptionEndDateWidget extends StatelessWidget {
  final DateTime endDate;
  final void Function()? onPressed;
  const SubscriptionEndDateWidget({
    super.key,
    required this.endDate,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('dd/MM/yyyy').format(endDate);
    final bool isToday = DateTime.now().difference(endDate).inDays == 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            formattedDate,
            style: context.bodyLarge!.copyWith(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          ElevatedButton(
            onPressed: isToday ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isToday ? Colors.blue : Colors.grey[300],
              foregroundColor: isToday ? Colors.white : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
            ),
            child: Text(
              context.translate(LocalizationKeys.renew),
              style: context.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
