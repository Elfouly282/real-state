import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../features/properties/domain/entities/property_entity.dart';
import 'admin_image_preview_dialog.dart';

class AdminImagesCell extends StatelessWidget {
  final List<PropertyImageEntity> images;
  const AdminImagesCell({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Icon(Icons.hide_image_outlined, size: 20, color: AppColors.grey);
    }
    return IconButton(
      tooltip: '${images.length} image${images.length > 1 ? 's' : ''}',
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.photo_library_outlined,
              size: 22, color: AppColors.infoColor),
          if (images.length > 1)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${images.length}',
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      onPressed: () => _showPreview(context),
    );
  }

  void _showPreview(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => AdminImagePreviewDialog(images: images),
    );
  }
}
