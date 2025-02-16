import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final BoxFit? fit;
  const LogoWidget({super.key, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset("AppAssetPaths.nasebakLogo", fit: fit ?? BoxFit.cover);
  }
}
