import 'package:real_state/features/property_details/data/models/property_agent_model.dart';
import 'package:real_state/features/property_details/data/models/property_image_model.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';

class PropertyDetailsModel extends PropertyEntity {
  PropertyDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.listing_type,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.rating,
    required super.lat,
    required super.lng,
    required super.address,
    required super.distanceKm,
    required super.images,
    super.agentInfo,
  });
  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return PropertyDetailsModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      listing_type: data['listing_type'],
      bedrooms: data['bedrooms'],
      bathrooms: data['bathrooms'],
      kitchens: data['kitchens'],
      rating: (data['rate'] as num).toDouble(),
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      address: data['address'],
      distanceKm: (data['distance_km'] as num).toDouble(),
      images: (data['images'] as List)
          .map((e) => PropertyImageModel.fromJson(e))
          .toList(),
      agentInfo: data['agent'] != null
          ? PropertyAgentModel.fromJson(data['agent'])
          : null,
    );
  }
}
