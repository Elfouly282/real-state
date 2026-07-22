import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUsecase _get;
  final CreateCategoryUsecase _create;
  final UpdateCategoryUsecase _update;
  final DeleteCategoryUsecase _delete;

  CategoriesCubit(this._get, this._create, this._update, this._delete)
      : super(CategoriesInitial());

  Future<void> load({int perPage = 50, int page = 1}) async {
    if (state is! CategoriesSuccess) emit(CategoriesLoading());
    final res = await _get(perPage: perPage, page: page);
    res.fold(
      (f) => emit(CategoriesFailure(f.message)),
      (paginated) => emit(CategoriesSuccess(paginated.data, paginated.meta)),
    );
  }

  Future<void> create({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) async {
    emit(CategoriesActionLoading());
    final res = await _create(
      name: name,
      slug: slug,
      description: description,
      sortOrder: sortOrder,
    );
    await res.fold(
      (f) async => emit(CategoriesFailure(f.message)),
      (_) async => load(),
    );
  }

  Future<void> update(int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) async {
    emit(CategoriesActionLoading());
    final res = await _update(id,
      name: name,
      slug: slug,
      description: description,
      sortOrder: sortOrder,
    );
    await res.fold(
      (f) async => emit(CategoriesFailure(f.message)),
      (_) async => load(),
    );
  }

  Future<void> delete(int id) async {
    emit(CategoriesActionLoading());
    final res = await _delete(id);
    await res.fold(
      (f) async => emit(CategoriesFailure(f.message)),
      (_) async => load(),
    );
  }
}
