part of 'categories_cubit.dart';

abstract class CategoriesState {}
class CategoriesInitial extends CategoriesState {}
class CategoriesLoading extends CategoriesState {}
class CategoriesActionLoading extends CategoriesState {}
class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> list;
  CategoriesSuccess(this.list);
}
class CategoriesFailure extends CategoriesState {
  final String message;
  CategoriesFailure(this.message);
}
