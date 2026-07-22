import 'category_entity.dart';
import 'property_entity.dart';

class HomeEntity {
  final List<CategoryEntity> categories;
  final List<PropertyEntity> bestSelling;
  final List<PropertyEntity> featured;
  final List<PropertyEntity> recommended;

  const HomeEntity({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });
}
