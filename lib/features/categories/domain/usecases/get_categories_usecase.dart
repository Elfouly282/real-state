import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUsecase {
  final CategoriesRepository _repo;
  GetCategoriesUsecase(this._repo);

  Future<Either<Failure, List<CategoryEntity>>> call({int perPage = 50}) =>
      _repo.getCategories(perPage: perPage);
}

class CreateCategoryUsecase {
  final CategoriesRepository _repo;
  CreateCategoryUsecase(this._repo);

  Future<Either<Failure, CategoryEntity>> call({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) =>
      _repo.createCategory(
        name: name,
        slug: slug,
        description: description,
        sortOrder: sortOrder,
      );
}

class UpdateCategoryUsecase {
  final CategoriesRepository _repo;
  UpdateCategoryUsecase(this._repo);

  Future<Either<Failure, CategoryEntity>> call(
    int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) =>
      _repo.updateCategory(
        id,
        name: name,
        slug: slug,
        description: description,
        sortOrder: sortOrder,
      );
}

class DeleteCategoryUsecase {
  final CategoriesRepository _repo;
  DeleteCategoryUsecase(this._repo);

  Future<Either<Failure, bool>> call(int id) => _repo.deleteCategory(id);
}
