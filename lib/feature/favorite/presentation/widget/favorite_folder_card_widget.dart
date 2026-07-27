import 'package:flutter/material.dart';
import 'package:real_state/core/constant/cached_image_widget.dart';
// تأكد من ضبط مسار استيراد CachedImageWidget حسب مشروعك
// import 'package:real_state/core/widgets/cached_image_widget.dart';

class FavoriteFolderCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> images;
  final VoidCallback onTap;

  const FavoriteFolderCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.images,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImageGrid(),
              ),
            ),
            const SizedBox(height: 12),

            
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

           
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// بناء شبكة الصور داخل المجلد اعتماداً على عدد الصور المتاحة
  Widget _buildImageGrid() {
    if (images.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
        ),
      );
    }

    // صورة واحدة
    if (images.length == 1) {
      return images.first.cachedImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // صورتين (تقسيم نصفين)
    if (images.length == 2) {
      return Row(
        children: [
          Expanded(
            child: images[0].cachedImage(
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: images[1].cachedImage(
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }

    // 3 أو 4 صور (شبكة 2x2)
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: images[0].cachedImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: images[1].cachedImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: images[2].cachedImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: images.length > 3
                    ? images[3].cachedImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(color: Colors.grey[200]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}