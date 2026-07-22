import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'custom_png_image.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    this.color,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CustomPngImage(
      color: color,
      path: Assets.png.logo.path,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
