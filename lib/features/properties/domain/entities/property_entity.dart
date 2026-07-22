import 'property_image_entity.dart';
import 'property_category_entity.dart';
import 'property_agent_entity.dart';

export 'property_image_entity.dart';
export 'property_category_entity.dart';
export 'property_agent_user_entity.dart';
export 'property_agent_entity.dart';
export 'property_params.dart';

class PropertyEntity {
  final int id;
  final String title;
  final String slug;
  final String? description;
  final double price;
  final String listingType;
  final String status;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final bool isFeatured;
  final int salesCount;
  final double rate;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? distanceKm;
  final List<PropertyImageEntity> images;
  final PropertyCategoryEntity? category;
  final PropertyAgentEntity? agent;
  final String createdAt;

  const PropertyEntity({
    required this.id,
    required this.title,
    required this.slug,
    this.description,
    required this.price,
    required this.listingType,
    required this.status,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.isFeatured,
    required this.salesCount,
    required this.rate,
    this.latitude,
    this.longitude,
    this.address,
    this.distanceKm,
    this.images = const [],
    this.category,
    this.agent,
    required this.createdAt,
  });

  String? get firstImageUrl =>
      images.isNotEmpty ? images.first.url : null;
}
