import 'package:real_state/features/home/domain/entity/property_entity.dart';

import 'category_model.dart';
import 'image_model.dart';

class PropertyModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final String address;
  final double? latitude;
  final double? longitude;
  final double rate;
  final CategoryModel category;
  final List<ImageModel> images;
  final double? distance;

  PropertyModel({
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

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      rate: (json['rate'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      category: CategoryModel.fromJson(json['category']),

      images: (json['images'] as List)
          .map((e) => ImageModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'rate': rate,
      'distance': distance,
      'category': category.toJson(),
      'images': images.map((e) => e.toJson()).toList(),
    };
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      address: address,
      latitude: latitude,
      longitude: longitude,
      rate: rate,
      distance: distance,
      category: category.toEntity(),
      images: images.map((e) => e.toEntity()).toList(),
    );
  }
}
