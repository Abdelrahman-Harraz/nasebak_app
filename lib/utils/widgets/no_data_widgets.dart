import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;

  const NoDataWidget({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message ?? context.translate(LocalizationKeys.noData)),
    );
  }
}
