part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesActionLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> list;
  final CategoryPaginationMeta meta;
  CategoriesSuccess(this.list, this.meta);
}

class CategoriesFailure extends CategoriesState {
  final String message;
  CategoriesFailure(this.message);
}
