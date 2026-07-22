import 'package:flutter/material.dart';
import '../../core/constant/cached_image_widget.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/properties/domain/entities/property_entity.dart';

class AdminImagePreviewDialog extends StatefulWidget {
  final List<PropertyImageEntity> images;
  const AdminImagePreviewDialog({super.key, required this.images});

  @override
  State<AdminImagePreviewDialog> createState() => AdminImagePreviewDialogState();
}

class AdminImagePreviewDialogState extends State<AdminImagePreviewDialog> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final imgW = (screenW * 0.75).clamp(300.0, 900.0);
    final imgH = (screenH * 0.65).clamp(200.0, 600.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: imgW,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                  child: Row(
                    children: [
                      const Icon(Icons.photo_library_outlined,
                          color: AppColors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        '${_current + 1} / ${widget.images.length}',
                        style: getMediumStyle(
                            fontSize: AppFonts.bodyMedium,
                            color: AppColors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16)),
                  child: SizedBox(
                    width: imgW,
                    height: imgH,
                    child: CachedImageWidget(
                      imageUrl: widget.images[_current].url,
                      width: imgW,
                      height: imgH,
                      fit: BoxFit.cover,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16)),
                    ),
                  ),
                ),
                if (widget.images.length > 1)
                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => setState(() => _current = i),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: i == _current
                                  ? AppColors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedImageWidget(
                              imageUrl: widget.images[i].url,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (widget.images.length > 1) ...[
            Positioned(
              left: 0,
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_left,
                      color: AppColors.white, size: 28),
                ),
                onPressed: _current > 0
                    ? () => setState(() => _current--)
                    : null,
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_right,
                      color: AppColors.white, size: 28),
                ),
                onPressed: _current < widget.images.length - 1
                    ? () => setState(() => _current++)
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
