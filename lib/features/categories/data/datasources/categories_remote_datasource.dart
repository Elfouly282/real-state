import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoriesRemoteDatasource {
  Future<PaginatedCategoriesModel> getCategories({int perPage = 50, int page = 1});
  Future<CategoryModel> getCategory(int id);
  Future<CategoryModel> createCategory({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  });
  Future<CategoryModel> updateCategory(
    int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  });
  Future<bool> deleteCategory(int id);
}

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  @override
  Future<PaginatedCategoriesModel> getCategories({
    int perPage = 50,
    int page = 1,
  }) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listCategories,
        query: {'per_page': perPage, 'page': page},
        withAuth: true,
      );
      return PaginatedCategoriesModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<CategoryModel> getCategory(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getCategory(id),
        withAuth: true,
      );
      return CategoryModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
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
      final body = <String, dynamic>{'name': name};
      if (slug != null) body['slug'] = slug;
      if (description != null) body['description'] = description;
      if (sortOrder != null) body['sort_order'] = sortOrder;

      final res = await DioHelper.postData(
        url: EndPoints.createCategory,
        data: body,
        withAuth: true,
      );
      return CategoryModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
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
      final body = <String, dynamic>{'name': name};
      if (slug != null) body['slug'] = slug;
      if (description != null) body['description'] = description;
      if (sortOrder != null) body['sort_order'] = sortOrder;

      final res = await DioHelper.putDataWithAuth(
        url: EndPoints.updateCategory(id),
        data: body,
        withAuth: true,
      );
      return CategoryModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
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
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
