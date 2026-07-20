import 'package:real_state/features/property_details/domain/entities/property_agent_entity.dart';
import 'package:real_state/features/property_details/domain/entities/property_image_entity.dart';

class PropertyEntity {
  final int id;
  final String title;
  final String description;
  final String price;
  final String listing_type;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final double rating;
  final double lat;
  final double lng;
  final String address;
  final double distanceKm;
  final List<PropertyImageEntity> images;
  final PropertyAgentEntity? agentInfo;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.listing_type,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.rating,
    required this.lat,
    required this.lng,
    required this.address,
    required this.distanceKm,
    required this.images,
    required this.agentInfo,
  });
}
