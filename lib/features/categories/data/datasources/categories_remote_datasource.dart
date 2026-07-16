import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/failure.dart';
import '../models/category_model.dart';

abstract class CategoriesRemoteDatasource {
  Future<List<CategoryModel>> getCategories({int perPage = 50});
  Future<CategoryModel> getCategory(int id);
  Future<CategoryModel> createCategory({required String name, String? slug, String? description, int? sortOrder});
  Future<CategoryModel> updateCategory(int id, {required String name, String? slug, String? description, int? sortOrder});
  Future<bool> deleteCategory(int id);
}

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  @override
  Future<List<CategoryModel>> getCategories({int perPage = 50}) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listCategories,
        query: {'per_page': perPage},
        withAuth: true,
      );
      // Response: [{ "data": [ {...}, {...} ] }]
      final list = _extractList(res.data);
      return list
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  @override
  Future<CategoryModel> getCategory(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getCategory(id),
        withAuth: true,
      );
      return CategoryModel.fromJson(_extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  @override
  Future<CategoryModel> createCategory({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) async {
    try {
      final res = await DioHelper.postData(
        url: EndPoints.createCategory,
        data: {
          'name': name,
          if (slug != null) 'slug': slug,
          if (description != null) 'description': description,
          if (sortOrder != null) 'sort_order': sortOrder,
        },
        withAuth: true,
      );
      return CategoryModel.fromJson(_extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  @override
  Future<CategoryModel> updateCategory(
    int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) async {
    try {
      final res = await DioHelper.putDataWithAuth(
        url: EndPoints.updateCategory(id),
        data: {
          'name': name,
          if (slug != null) 'slug': slug,
          if (description != null) 'description': description,
          if (sortOrder != null) 'sort_order': sortOrder,
        },
        withAuth: true,
      );
      return CategoryModel.fromJson(_extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  @override
  Future<bool> deleteCategory(int id) async {
    try {
      await DioHelper.deleteDataWithAuth(
        url: EndPoints.deleteCategory(id),
        withAuth: true,
      );
      return true;
    } on DioException catch (e) {
      throw ServerException(_msg(e));
    }
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  /// Extracts list from: [{ "data": [...] }]  or  { "data": [...] }  or  [...]
  List _extractList(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0];
      if (first is Map && first['data'] is List) return first['data'] as List;
      return raw;
    }
    if (raw is Map && raw['data'] is List) return raw['data'] as List;
    return [];
  }

  /// Extracts single object from: [{ "data": {...} }]  or  { "data": {...} }
  Map<String, dynamic> _extractSingle(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0] as Map;
      return (first['data'] ?? first) as Map<String, dynamic>;
    }
    if (raw is Map) return (raw['data'] ?? raw) as Map<String, dynamic>;
    return {};
  }

  String _msg(DioException e) {
    final d = e.response?.data;
    if (d is List && d.isNotEmpty) return (d[0] as Map)['message'] ?? e.message ?? '';
    if (d is Map) return d['message'] ?? e.message ?? '';
    return e.message ?? 'Unknown error';
  }
}
