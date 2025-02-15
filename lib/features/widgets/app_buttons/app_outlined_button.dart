import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? width;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: Size(width ?? 320, 46),
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.r)),
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        onPressed: onPressed,
        child: child);
  }
}
