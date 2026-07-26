import 'package:real_state/feature/favorite/domain/entity/property_entity.dart';


class FavoritePropertyModel extends PropertyEntity {
  FavoritePropertyModel({
    required super.id,
    required super.title,
    required super.price,
    required super.address,
    required super.rate,
    required super.imageUrls,
    super.isFavorite,
  });

  factory FavoritePropertyModel.fromJson(Map<String, dynamic> json) {
    final data = json.containsKey('data') ? json['data'] : json;

    return FavoritePropertyModel(
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      price: data['price']?.toString() ?? '0',
      address: data['address'] ?? '',
      rate: (data['rate'] as num?)?.toDouble() ?? 0.0,
      imageUrls: (data['images'] as List?)
              ?.map((img) => img['url'].toString())
              .toList() ??
          [],
      isFavorite: true, 
    );
  }
}