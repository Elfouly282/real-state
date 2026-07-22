import '../../domain/entities/property_entity.dart';

class PropertyImageModel extends PropertyImageEntity {
  const PropertyImageModel({
    required super.id,
    required super.url,
    required super.sortOrder,
  });

  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String? ?? '',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );
  }
}

class PropertyCategoryModel extends PropertyCategoryEntity {
  const PropertyCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.description,
    required super.sortOrder,
  });

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );
  }
}

class PropertyAgentUserModel extends PropertyAgentUserEntity {
  const PropertyAgentUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.location,
    super.phone,
    required super.createdAt,
  });

  factory PropertyAgentUserModel.fromJson(Map<String, dynamic> json) {
    return PropertyAgentUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}

class PropertyAgentModel extends PropertyAgentEntity {
  const PropertyAgentModel({
    required super.id,
    required super.title,
    super.bio,
    super.licenseNumber,
    super.company,
    super.user,
  });

  factory PropertyAgentModel.fromJson(Map<String, dynamic> json) {
    final userRaw = json['user'];
    PropertyAgentUserModel? user;
    if (userRaw is List && userRaw.isNotEmpty) {
      user = PropertyAgentUserModel.fromJson(userRaw[0] as Map<String, dynamic>);
    } else if (userRaw is Map<String, dynamic>) {
      user = PropertyAgentUserModel.fromJson(userRaw);
    }
    return PropertyAgentModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      bio: json['bio'] as String?,
      licenseNumber: json['license_number'] as String?,
      company: json['company'] as String?,
      user: user,
    );
  }
}

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required super.id,
    required super.title,
    required super.slug,
    super.description,
    required super.price,
    required super.listingType,
    required super.status,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.isFeatured,
    required super.salesCount,
    required super.rate,
    super.latitude,
    super.longitude,
    super.address,
    super.distanceKm,
    super.images,
    super.category,
    super.agent,
    required super.createdAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'] as List? ?? [];
    final images = rawImages
        .map((e) => PropertyImageModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final catJson = json['category'];
    final category = catJson is List && catJson.isNotEmpty
        ? PropertyCategoryModel.fromJson(catJson[0] as Map<String, dynamic>)
        : catJson is Map<String, dynamic>
            ? PropertyCategoryModel.fromJson(catJson)
            : null;

    final agentJson = json['agent'];
    final agent = agentJson is List && agentJson.isNotEmpty
        ? PropertyAgentModel.fromJson(agentJson[0] as Map<String, dynamic>)
        : agentJson is Map<String, dynamic>
            ? PropertyAgentModel.fromJson(agentJson)
            : null;

    return PropertyModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      listingType: json['listing_type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
      bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
      kitchens: (json['kitchens'] as num?)?.toInt() ?? 0,
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
      salesCount: (json['sales_count'] as num?)?.toInt() ?? 0,
      rate: json['rate'] != null
          ? (double.tryParse(json['rate'].toString()) ?? 0.0)
          : 0.0,
      latitude: double.tryParse(
          (json['latitude'] ?? json['lat'])?.toString() ?? ''),
      longitude: double.tryParse(
          (json['longitude'] ?? json['lng'])?.toString() ?? ''),
      address: json['address'] as String?,
      distanceKm: double.tryParse(json['distance_km']?.toString() ?? ''),
      images: images,
      category: category,
      agent: agent,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
