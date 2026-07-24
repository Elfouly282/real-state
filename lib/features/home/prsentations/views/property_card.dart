import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/cached_image_widget.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/home/domain/entity/property_entity.dart';

class PropertyCard extends StatefulWidget {
  final PropertyEntity property;
  final VoidCallback onTap;
  const PropertyCard({super.key, required this.property, required this.onTap});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 227.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 227 / 147,
                  child: CachedImageWidget(
                    imageUrl: widget.property.images.first.url,
                    width: double.infinity,

                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    width: 76.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/png/sale_icon.png'),
                        Text(
                          "For Sale",
                          style: getMediumStyle(
                            fontSize: 10.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.property.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: getMediumStyle(
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 22.sp,
                        padding: EdgeInsets.zero,
                        icon: isFavorite
                            ? Icon(Icons.star, color: AppColors.yello)
                            : Icon(Icons.star_border),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  /// Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: Color(0xff1597A8),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          widget.property.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            fontSize: 10.sp,
                            color: AppColors.black.withOpacity(.52),
                          ),
                        ),
                      ),
                      Container(
                        height: 16.h,
                        width: 1.w,
                        color: Colors.black.withOpacity(.52),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.navigation_outlined,
                        size: 16.sp,
                        color: Color(0xff1597A8),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        widget.property.distance.toString(),
                        style: getRegularStyle(
                          fontSize: 10.sp,
                          color: AppColors.black.withOpacity(.52),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.property.price.toString(),
                        style: getBoldStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, size: 16, color: AppColors.yello),

                      SizedBox(width: 4.w),
                      Text(
                        widget.property.rate.toString(),
                        style: getRegularStyle(
                          fontSize: 12.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
