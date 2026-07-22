import 'package:flutter/material.dart';
import '../../core/constant/app_constants.dart';
import '../../core/utils/status_badge_helper.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/properties/domain/entities/property_entity.dart';
import 'widgets/property_detail_helpers.dart';
import 'widgets/property_image_carousel.dart';

class PropertyDetailsPage extends StatelessWidget {
  final PropertyEntity property;

  const PropertyDetailsPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          property.title,
          style: getBoldStyle(
            fontSize: AppFonts.titleMedium,
            color: AppColors.secondaryColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          PropertyStatusBadge(
            status: property.status,
            color: propertyStatusColor(property.status),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(builder: (_, constraints) {
          final isWide =
              constraints.maxWidth >= AppConstants.kBreakpointSidebar;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: PropertyDetailLeftColumn(property: property),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 3,
                      child: PropertyDetailRightColumn(property: property),
                    ),
                  ],
                )
              : Column(
                  children: [
                    PropertyDetailLeftColumn(property: property),
                    const SizedBox(height: 24),
                    PropertyDetailRightColumn(property: property),
                  ],
                );
        }),
      ),
    );
  }
}


class PropertyDetailLeftColumn extends StatelessWidget {
  final PropertyEntity property;

  const PropertyDetailLeftColumn({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final p = property;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (p.images.isNotEmpty)
          PropertyImageCarousel(images: p.images)
        else
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: AppColors.greychip,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.hide_image_outlined,
                size: 48,
                color: AppColors.grey,
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (p.description != null && p.description!.isNotEmpty) ...[
          const PropertyDetailSectionTitle(title: 'Description'),
          const SizedBox(height: 8),
          PropertyDetailCard(
            child: Text(
              p.description!,
              style: getRegularStyle(
                fontSize: AppFonts.bodyMedium,
                color: AppColors.textPrimaryColor,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
        const PropertyDetailSectionTitle(title: 'Features'),
        const SizedBox(height: 8),
        PropertyDetailCard(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PropertyFeatureChip(
                icon: Icons.bed_outlined,
                label: '${p.bedrooms} Bedrooms',
              ),
              PropertyFeatureChip(
                icon: Icons.bathtub_outlined,
                label: '${p.bathrooms} Bathrooms',
              ),
              PropertyFeatureChip(
                icon: Icons.kitchen_outlined,
                label: '${p.kitchens} Kitchens',
              ),
              PropertyFeatureChip(
                icon: Icons.star_outline,
                label: p.rate > 0
                    ? 'Rating: ${p.rate.toStringAsFixed(1)}'
                    : 'No Rating',
              ),
              if (p.isFeatured)
                const PropertyFeatureChip(
                  icon: Icons.verified_outlined,
                  label: 'Featured',
                  color: AppColors.warningColor,
                ),
            ],
          ),
        ),
      ],
    );
  }
}


class PropertyDetailRightColumn extends StatelessWidget {
  final PropertyEntity property;

  const PropertyDetailRightColumn({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final p = property;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PropertyDetailSectionTitle(title: 'Pricing'),
        const SizedBox(height: 8),
        PropertyDetailCard(
          child: Column(
            children: [
              PropertyInfoRow(
                icon: Icons.attach_money_outlined,
                label: 'Price',
                value: '\$${p.price.toStringAsFixed(0)}',
                valueColor: AppColors.successColor,
              ),
              const Divider(height: 20),
              PropertyInfoRow(
                icon: Icons.swap_horiz_outlined,
                label: 'Listing Type',
                value: p.listingType.toUpperCase(),
              ),
              const Divider(height: 20),
              PropertyInfoRow(
                icon: Icons.star_outline,
                label: 'Rate',
                value: p.rate > 0 ? p.rate.toStringAsFixed(1) : 'No Rating',
                valueColor: p.rate > 0 ? AppColors.warningColor : null,
              ),
              const Divider(height: 20),
              PropertyInfoRow(
                icon: Icons.trending_up_outlined,
                label: 'Sales Count',
                value: '${p.salesCount}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (p.address != null || p.latitude != null) ...[
          const PropertyDetailSectionTitle(title: 'Location'),
          const SizedBox(height: 8),
          PropertyDetailCard(
            child: Column(
              children: [
                if (p.address != null)
                  PropertyInfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: p.address!,
                  ),
                if (p.address != null && p.latitude != null)
                  const Divider(height: 20),
                if (p.latitude != null)
                  PropertyInfoRow(
                    icon: Icons.my_location_outlined,
                    label: 'Coordinates',
                    value:
                        '${p.latitude?.toStringAsFixed(4)}, ${p.longitude?.toStringAsFixed(4)}',
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (p.category != null) ...[
          const PropertyDetailSectionTitle(title: 'Category'),
          const SizedBox(height: 8),
          PropertyDetailCard(
            child: Column(
              children: [
                PropertyInfoRow(
                  icon: Icons.category_outlined,
                  label: 'Name',
                  value: p.category!.name,
                ),
                const Divider(height: 20),
                PropertyInfoRow(
                  icon: Icons.tag_outlined,
                  label: 'Slug',
                  value: p.category!.slug,
                ),
                if (p.category!.description != null) ...[
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.notes_outlined,
                    label: 'Description',
                    value: p.category!.description!,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (p.agent != null) ...[
          const PropertyDetailSectionTitle(title: 'Agent'),
          const SizedBox(height: 8),
          PropertyDetailCard(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primaryColor,
                      child: Text(
                        p.agent!.title.isNotEmpty
                            ? p.agent!.title[0].toUpperCase()
                            : 'A',
                        style: getBoldStyle(
                          fontSize: AppFonts.titleSmall,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.agent!.title,
                            style: getMediumStyle(
                              fontSize: AppFonts.bodyMedium,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          if (p.agent!.company != null)
                            Text(
                              p.agent!.company!,
                              style: getRegularStyle(
                                fontSize: AppFonts.bodySmall,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (p.agent!.bio != null) ...[
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.info_outline,
                    label: 'Bio',
                    value: p.agent!.bio!,
                  ),
                ],
                if (p.agent?.user != null) ...[
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: p.agent!.user!.name,
                  ),
                  const Divider(height: 20),
                  PropertyInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: p.agent!.user!.email,
                  ),
                  if (p.agent!.user!.phone != null) ...[
                    const Divider(height: 20),
                    PropertyInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: p.agent!.user!.phone!,
                    ),
                  ],
                  if (p.agent!.user!.location != null) ...[
                    const Divider(height: 20),
                    PropertyInfoRow(
                      icon: Icons.location_city_outlined,
                      label: 'Location',
                      value: p.agent!.user!.location!,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
