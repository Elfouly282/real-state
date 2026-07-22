import 'package:real_state/features/property_for_you/domain/Entites/similer_property_image_entity.dart';

class SimilerPropertyEntity {
  final int id;
  final String title;
  final String price;
  final double rating;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final String address;
  final double distance_km;
  final SimilerPropertyImageEntity image;

  SimilerPropertyEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.address,
    required this.distance_km,
    required this.image,
  });
}
