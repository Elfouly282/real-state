import 'package:real_state/features/home/domain/entity/home_entity.dart';

import 'category_model.dart';
import 'property_model.dart';

class HomeResponseModel {
  final List<CategoryModel> categories;
  final List<PropertyModel> bestSelling;
  final List<PropertyModel> featured;
  final List<PropertyModel> recommended;

  HomeResponseModel({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return HomeResponseModel(
      categories: (data['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),

      bestSelling: (data['best_selling'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),

      featured: (data['featured'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),

      recommended: (data['recommended'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList(),
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(
      categories: categories.map((e) => e.toEntity()).toList(),
      bestSelling: bestSelling.map((e) => e.toEntity()).toList(),
      featured: featured.map((e) => e.toEntity()).toList(),
      recommended: recommended.map((e) => e.toEntity()).toList(),
    );
  }
}
