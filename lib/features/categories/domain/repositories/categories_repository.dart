import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories({int perPage = 50});
  Future<Either<Failure, CategoryEntity>> getCategory(int id);
  Future<Either<Failure, CategoryEntity>> createCategory({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  });
  Future<Either<Failure, CategoryEntity>> updateCategory(
    int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  });
  Future<Either<Failure, bool>> deleteCategory(int id);
}
