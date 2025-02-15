import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  final EdgeInsets? padding;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        onPressed: onPressed,
        child: child);
  }
}
