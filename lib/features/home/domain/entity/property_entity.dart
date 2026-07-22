import 'category_entity.dart';
import 'image_entity.dart';

class PropertyEntity {
  final int id;
  final String title;
  final String description;
  final String price;
  final String address;
  final double? latitude;
  final double? longitude;
  final double rate;
  final CategoryEntity category;
  final List<ImageEntity> images;
  final double? distance;

  const PropertyEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.category,
    required this.images,
    required this.distance,
  });
}
