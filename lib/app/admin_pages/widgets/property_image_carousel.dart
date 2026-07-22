import 'package:flutter/material.dart';
import '../../../core/constant/cached_image_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../features/properties/domain/entities/property_entity.dart';

class PropertyImageCarousel extends StatefulWidget {
  final List<PropertyImageEntity> images;

  const PropertyImageCarousel({super.key, required this.images});

  @override
  State<PropertyImageCarousel> createState() => PropertyImageCarouselState();
}

class PropertyImageCarouselState extends State<PropertyImageCarousel> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedImageWidget(
            imageUrl: widget.images[_currentImage].url,
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
        ),
        if (widget.images.length > 1) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => _currentImage = i),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: i == _currentImage
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedImageWidget(
                      imageUrl: widget.images[i].url,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
