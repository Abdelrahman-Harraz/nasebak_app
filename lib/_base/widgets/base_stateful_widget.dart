import 'package:flutter/material.dart';
import 'package:nasebak_app/_base/platform_manager.dart';
import 'package:nasebak_app/_base/screen_sizer.dart';
import 'package:nasebak_app/_base/themer.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseState createState() => baseCreateState();

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with ScreenSizer, PlatformManager, Themer {
  @override
  void didChangeDependencies() {
    initScreenSizer(context);
    initThemer(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
