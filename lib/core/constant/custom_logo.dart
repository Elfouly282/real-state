import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'custom_png_image.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CustomPngImage(
      path: Assets.svg.logo,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
