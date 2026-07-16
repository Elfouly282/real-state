import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/failure.dart';
import '../models/property_model.dart';

abstract class PropertiesRemoteDatasource {
  Future<List<PropertyModel>> getProperties();
  Future<PropertyModel> getProperty(int id);
  Future<PropertyModel> createProperty(Map<String, dynamic> data);
  Future<PropertyModel> updateProperty(int id, Map<String, dynamic> data);
  Future<bool> deleteProperty(int id);
}

class PropertiesRemoteDatasourceImpl implements PropertiesRemoteDatasource {
  @override
  Future<List<PropertyModel>> getProperties() async {
    try {
      final res = await DioHelper.getData(url: EndPoints.listProperties, withAuth: true);
      final list = _extractList(res.data);
      return list.map((e) => PropertyModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<PropertyModel> getProperty(int id) async {
    try {
      final res = await DioHelper.getData(url: EndPoints.getProperty(id), withAuth: true);
      return PropertyModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<PropertyModel> createProperty(Map<String, dynamic> data) async {
    try {
      final res = await DioHelper.postData(url: EndPoints.createProperty, data: data, withAuth: true);
      return PropertyModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<PropertyModel> updateProperty(int id, Map<String, dynamic> data) async {
    try {
      final res = await DioHelper.putDataWithAuth(url: EndPoints.updateProperty(id), data: data, withAuth: true);
      return PropertyModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<bool> deleteProperty(int id) async {
    try {
      await DioHelper.deleteDataWithAuth(url: EndPoints.deleteProperty(id), withAuth: true);
      return true;
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  List _extractList(dynamic raw) {
    if (raw is List) return raw;
    if (raw is Map && raw['data'] is List) return raw['data'] as List;
    return [];
  }

  Map<String, dynamic> _extractData(dynamic raw) {
    if (raw is List && raw.isNotEmpty) {
      final first = raw[0] as Map;
      return (first['data'] ?? first) as Map<String, dynamic>;
    }
    if (raw is Map) return (raw['data'] ?? raw) as Map<String, dynamic>;
    return {};
  }

  String _msg(DioException e) {
    final d = e.response?.data;
    if (d is Map) return d['message'] ?? e.message ?? '';
    return e.message ?? 'Unknown error';
  }
}
