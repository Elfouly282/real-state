import '../../domain/entities/property_entity.dart';

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required super.id,
    required super.title,
    super.description,
    required super.price,
    required super.status,
    super.type,
    super.city,
    super.imageUrl,
    super.categoryId,
    super.agentId,
    required super.createdAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '',
      type: json['type'] as String?,
      city: json['city'] as String?,
      imageUrl: json['image'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      agentId: (json['agent_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
