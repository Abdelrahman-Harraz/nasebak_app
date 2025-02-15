import 'package:flutter/material.dart';
import 'package:nasebak_app/_base/loading_manager.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_widget.dart';

abstract class BaseStatefulScreenWidget extends BaseStatefulWidget {
  const BaseStatefulScreenWidget({super.key});

  @override
  BaseScreenState baseCreateState() => baseScreenCreateState();

  BaseScreenState baseScreenCreateState();
}

abstract class BaseScreenState<W extends BaseStatefulScreenWidget>
    extends BaseState<W>
    with LoadingManager {
  @override
  Widget baseBuild(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [baseScreenBuild(context), loadingManagerWidget()],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  @override
  BuildContext provideContext() {
    return context;
  }

  Widget baseScreenBuild(BuildContext context);
}
