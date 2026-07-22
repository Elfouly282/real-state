import 'package:flutter/material.dart';

class CustomPngImage extends StatelessWidget {
  const CustomPngImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
  });

  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Color? color;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      path,
      height: height,
      width: width,
      fit: fit,
      color: color,
      colorBlendMode: color != null
          ? (colorBlendMode ?? BlendMode.srcIn)
          : null,
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}
