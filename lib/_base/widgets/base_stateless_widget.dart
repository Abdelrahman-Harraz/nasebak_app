import 'package:flutter/material.dart';
import 'package:nasebak_app/_base/platform_manager.dart';
import 'package:nasebak_app/_base/screen_sizer.dart';
import 'package:nasebak_app/_base/themer.dart';

// ignore: must_be_immutable
abstract class BaseStatelessWidget extends StatelessWidget
    with ScreenSizer, PlatformManager, Themer {
  BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    initScreenSizer(context);
    initThemer(context);
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
