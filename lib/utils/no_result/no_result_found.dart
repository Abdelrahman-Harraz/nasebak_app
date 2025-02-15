import 'package:flutter/material.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class NoResultFoundWidget extends StatelessWidget {
  final String? message;
  const NoResultFoundWidget({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message ?? context.translate(LocalizationKeys.noData)),
    );
  }
}
