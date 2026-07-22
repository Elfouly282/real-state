import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.description,
    required super.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );
  }
}

class PaginatedCategoriesModel extends PaginatedCategoriesEntity {
  const PaginatedCategoriesModel({required super.data, required super.meta});

  factory PaginatedCategoriesModel.fromJson(dynamic raw) {
    final Map<String, dynamic> root;
    if (raw is List && raw.isNotEmpty) {
      root = raw[0] as Map<String, dynamic>;
    } else if (raw is Map<String, dynamic>) {
      root = raw;
    } else {
      return PaginatedCategoriesModel(
        data: [],
        meta: CategoryPaginationMeta(
            currentPage: 1, lastPage: 1, perPage: 50, total: 0),
      );
    }

    final dataList = root['data'] as List? ?? [];
    final metaMap = root['meta'] as Map<String, dynamic>? ?? {};

    return PaginatedCategoriesModel(
      data: dataList
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: CategoryPaginationMeta(
        currentPage: (metaMap['current_page'] as num?)?.toInt() ?? 1,
        lastPage: (metaMap['last_page'] as num?)?.toInt() ?? 1,
        perPage: (metaMap['per_page'] as num?)?.toInt() ?? 50,
        total: (metaMap['total'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
