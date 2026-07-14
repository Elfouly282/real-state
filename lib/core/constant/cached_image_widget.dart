import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'custom_logo.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.filterQuality = FilterQuality.none,
    this.enableHighQuality = false,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final FilterQuality filterQuality;
  final bool enableHighQuality;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        // placeholder: (context, url) =>
        //     placeholder ?? _buildDefaultPlaceholder(),
        errorWidget: (context, url, error) =>
            errorWidget ?? _buildDefaultErrorWidget(),
        memCacheWidth: null,
        memCacheHeight: null,
        filterQuality: FilterQuality.none,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 100),
        maxWidthDiskCache: null,
        maxHeightDiskCache: null,
      ),
    );
  }

  // Widget _buildDefaultPlaceholder() {
  //   return Container(
  //     width: width,
  //     height: height,
  //     decoration: BoxDecoration(
  //       color: Colors.grey[200],
  //       borderRadius: borderRadius,
  //     ),
  //     child: Center(
  //       child: Image.asset(
  //         Assets.png.babaLogo.path,
  //         width: (width ?? 100) * 0.4,
  //         height: (height ?? 100) * 0.4,
  //         fit: BoxFit.contain,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: Center(
        child: CustomLogo(
          width: (width ?? 100) * 0.8,
          height: (height ?? 100) * 0.8,
        ),
      ),
    );
  }
}

extension CachedImageWidgetExtension on String {
  Widget cachedImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
    FilterQuality filterQuality = FilterQuality.none,
    bool enableHighQuality = false,
  }) {
    return CachedImageWidget(
      imageUrl: this,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      borderRadius: borderRadius,
      placeholder: placeholder,
      errorWidget: errorWidget,
      filterQuality: filterQuality,
      enableHighQuality: enableHighQuality,
    );
  }
}
