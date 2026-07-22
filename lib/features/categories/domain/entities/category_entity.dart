class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.sortOrder,
  });
}

class CategoryPaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const CategoryPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

class PaginatedCategoriesEntity {
  final List<CategoryEntity> data;
  final CategoryPaginationMeta meta;

  const PaginatedCategoriesEntity({
    required this.data,
    required this.meta,
  });
}
