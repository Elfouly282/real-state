import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/errors/failure.dart';
import '../models/agent_model.dart';

abstract class AgentsRemoteDatasource {
  Future<List<AgentModel>> getAgents();
  Future<AgentModel> getAgent(int id);
  Future<AgentModel> createAgent(Map<String, dynamic> data);
  Future<AgentModel> updateAgent(int id, Map<String, dynamic> data);
  Future<bool> deleteAgent(int id);
}

class AgentsRemoteDatasourceImpl implements AgentsRemoteDatasource {
  @override
  Future<List<AgentModel>> getAgents() async {
    try {
      final res = await DioHelper.getData(url: EndPoints.listAgents, withAuth: true);
      final list = _extractList(res.data);
      return list.map((e) => AgentModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<AgentModel> getAgent(int id) async {
    try {
      final res = await DioHelper.getData(url: EndPoints.getAgent(id), withAuth: true);
      return AgentModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<AgentModel> createAgent(Map<String, dynamic> data) async {
    try {
      final res = await DioHelper.postData(url: EndPoints.createAgent, data: data, withAuth: true);
      return AgentModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<AgentModel> updateAgent(int id, Map<String, dynamic> data) async {
    try {
      final res = await DioHelper.putDataWithAuth(url: EndPoints.updateAgent(id), data: data, withAuth: true);
      return AgentModel.fromJson(_extractData(res.data));
    } on DioException catch (e) { throw ServerException(_msg(e)); }
  }

  @override
  Future<bool> deleteAgent(int id) async {
    try {
      await DioHelper.deleteDataWithAuth(url: EndPoints.deleteAgent(id), withAuth: true);
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
