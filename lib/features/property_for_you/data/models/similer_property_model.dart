import 'package:real_state/features/property_for_you/data/models/similer_property_image_mode.dart';
import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';

class SimilerPropertyModel extends SimilerPropertyEntity {
  SimilerPropertyModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.address,
    required super.distance_km,
    required super.image,
  });
  factory SimilerPropertyModel.fromJson(Map<String, dynamic> json) {
    return SimilerPropertyModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      rating: (json['rate'] as num).toDouble(),
      distance_km: (json['distance_km'] as num).toDouble(),
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      kitchens: json['kitchens'],
      address: json['address'],
      image: SimilerPropertyImageMode.fromJson(json['images'][0]),
    );
  }
}
