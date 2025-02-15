import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetWithBackgroundWidget extends StatelessWidget {
  const WidgetWithBackgroundWidget({
    required this.backgroundImage,
    required this.child,
    super.key,
  });
  final String backgroundImage;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
        child,
      ],
    );
  }
}
