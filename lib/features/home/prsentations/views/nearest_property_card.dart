import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_state/core/constant/cached_image_widget.dart';
import 'package:real_state/core/utils/app_colors.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/home/domain/entity/property_entity.dart';

class NearestPropertyCard extends StatefulWidget {
  final PropertyEntity prop;
  final VoidCallback onTap;
  const NearestPropertyCard({
    super.key,
    required this.prop,
    required this.onTap,
  });

  @override
  State<NearestPropertyCard> createState() => _NearestPropertyCardState();
}

class _NearestPropertyCardState extends State<NearestPropertyCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 151.h,

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
        child: Row(
          children: [
            /// Image
            CachedImageWidget(
              imageUrl: widget.prop.images.first.url,
              width: 147.w,
              height: 151.h,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),

            SizedBox(width: 15.w),

            /// Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.prop.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: getMediumStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: isFavorite
                              ? Icon(
                                  Icons.star,
                                  size: 24,
                                  color: AppColors.yello,
                                )
                              : Icon(Icons.star_border, size: 24),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    /// Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xff1597A8),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            widget.prop.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getRegularStyle(
                              fontSize: 10,
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
                          size: 16,
                          color: Color(0xff1597A8),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "${widget.prop.distance} mile",
                          style: getRegularStyle(
                            fontSize: 10,
                            color: AppColors.black.withOpacity(.52),
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    /// Price & Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.prop.price}",
                          style: getBoldStyle(
                            fontSize: 16.sp,
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.star, size: 16, color: AppColors.yello),

                        SizedBox(width: 4.w),
                        Text(
                          widget.prop.rate.toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
