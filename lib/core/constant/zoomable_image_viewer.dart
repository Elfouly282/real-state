// import 'package:easy_image_viewer/easy_image_viewer.dart';
// import 'package:flutter/material.dart';
//
// class ZoomableImageViewer extends StatelessWidget {
//   final List<String> imageUrls;
//
//   final int initialIndex;
//
//   final Widget? child;
//
//   const ZoomableImageViewer({
//     super.key,
//     required this.imageUrls,
//     this.initialIndex = 0,
//     this.child,
//   });
//
//   static void show(
//     BuildContext context, {
//     required List<String> imageUrls,
//     int initialIndex = 0,
//     bool doubleTapZoomable = true,
//     bool swipeDismissible = true,
//   }) {
//     if (imageUrls.isEmpty) return;
//
//     if (imageUrls.length == 1) {
//       showImageViewer(
//         context,
//         NetworkImage(imageUrls.first),
//         doubleTapZoomable: doubleTapZoomable,
//         swipeDismissible: swipeDismissible,
//         onViewerDismissed: () {},
//       );
//     } else {
//       final multiImageProvider = MultiImageProvider(
//         imageUrls.map((url) => NetworkImage(url)).toList(),
//         initialIndex: initialIndex,
//       );
//       showImageViewerPager(
//         context,
//         multiImageProvider,
//         doubleTapZoomable: doubleTapZoomable,
//         swipeDismissible: swipeDismissible,
//         onPageChanged: (_) {},
//         onViewerDismissed: (_) {},
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (imageUrls.isEmpty) return;
//         show(context, imageUrls: imageUrls, initialIndex: initialIndex);
//       },
//       child: child,
//     );
//   }
// }
