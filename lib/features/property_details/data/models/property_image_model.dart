import 'package:real_state/features/property_details/domain/entities/property_image_entity.dart';

class PropertyImageModel extends PropertyImageEntity {
  PropertyImageModel({required super.url, required super.sortOrder});
  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(url: json['url'], sortOrder: json['sort_order']);
  }
}
