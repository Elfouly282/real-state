import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/property_entity.dart';
import '../models/property_model.dart';

export '../../domain/entities/property_params.dart';

abstract class PropertiesRemoteDatasource {
  Future<List<PropertyModel>> getProperties({int perPage = 20});
  Future<PropertyModel> getProperty(int id);
  Future<PropertyModel> createProperty(CreatePropertyParams params);
  Future<PropertyModel> updateProperty(int id, CreatePropertyParams params);
  Future<bool> deleteProperty(int id);
}

extension CreatePropertyParamsX on CreatePropertyParams {
  FormData toFormData({bool isUpdate = false}) {
    final fields = <MapEntry<String, dynamic>>[
      if (isUpdate) MapEntry('_method', 'PUT'),
      MapEntry('category_id', categoryId.toString()),
      MapEntry('assigned_agent_id', assignedAgentId.toString()),
      MapEntry('title', title),
      MapEntry('price', price),
      MapEntry('listing_type', listingType),
      MapEntry('bedrooms', bedrooms.toString()),
      MapEntry('bathrooms', bathrooms.toString()),
      MapEntry('kitchens', kitchens.toString()),
      MapEntry('status', status),
      MapEntry('is_featured', isFeatured.toString()),
      if (description != null) MapEntry('description', description!),
      if (address != null) MapEntry('address', address!),
      if (latitude != null) MapEntry('latitude', latitude!),
      if (longitude != null) MapEntry('longitude', longitude!),
    ];

    final formData = FormData.fromMap(Map.fromEntries(fields));
    for (final img in images) {
      formData.files.add(MapEntry('images[]', img));
    }
    return formData;
  }
}

class PropertiesRemoteDatasourceImpl implements PropertiesRemoteDatasource {
  @override
  Future<List<PropertyModel>> getProperties({int perPage = 20}) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listProperties,
        query: {'per_page': perPage},
        withAuth: true,
      );
      return ResponseParser.extractList(res.data)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<PropertyModel> getProperty(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getProperty(id),
        withAuth: true,
      );
      return PropertyModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<PropertyModel> createProperty(CreatePropertyParams params) async {
    try {
      final res = await DioHelper.postMultipartData(
        url: EndPoints.createProperty,
        formData: params.toFormData(),
        withAuth: true,
      );
      return PropertyModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<PropertyModel> updateProperty(
      int id, CreatePropertyParams params) async {
    try {
      final res = await DioHelper.postMultipartData(
        url: EndPoints.updateProperty(id),
        formData: params.toFormData(isUpdate: true),
        withAuth: true,
      );
      return PropertyModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<bool> deleteProperty(int id) async {
    try {
      await DioHelper.deleteDataWithAuth(
        url: EndPoints.deleteProperty(id),
        withAuth: true,
      );
      return true;
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
