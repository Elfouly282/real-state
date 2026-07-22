import 'package:dio/dio.dart';
import '../../../../core/api/constant_API.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/response_parser.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/agent_entity.dart';
import '../models/agent_model.dart';

abstract class AgentsRemoteDatasource {
  Future<PaginatedAgentsModel> getAgents({int perPage = 50, int page = 1});
  Future<AgentModel> getAgent(int id);
  Future<AgentModel> createAgent(CreateAgentParams params);
  Future<AgentModel> updateAgent(int id, CreateAgentParams params);
  Future<bool> deleteAgent(int id);
}

extension CreateAgentParamsX on CreateAgentParams {
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'user_id': userId,
      'title': title,
    };
    if (bio != null) map['bio'] = bio;
    if (licenseNumber != null) map['license_number'] = licenseNumber;
    if (company != null) map['company'] = company;
    return map;
  }
}

class AgentsRemoteDatasourceImpl implements AgentsRemoteDatasource {
  @override
  Future<PaginatedAgentsModel> getAgents({
    int perPage = 50,
    int page = 1,
  }) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.listAgents,
        query: {'per_page': perPage, 'page': page},
        withAuth: true,
      );
      return PaginatedAgentsModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<AgentModel> getAgent(int id) async {
    try {
      final res = await DioHelper.getData(
        url: EndPoints.getAgent(id),
        withAuth: true,
      );
      return AgentModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<AgentModel> createAgent(CreateAgentParams params) async {
    try {
      final res = await DioHelper.postData(
        url: EndPoints.createAgent,
        data: params.toJson(),
        withAuth: true,
      );
      return AgentModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<AgentModel> updateAgent(int id, CreateAgentParams params) async {
    try {
      final res = await DioHelper.putDataWithAuth(
        url: EndPoints.updateAgent(id),
        data: params.toJson(),
        withAuth: true,
      );
      return AgentModel.fromJson(ResponseParser.extractSingle(res.data));
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }

  @override
  Future<bool> deleteAgent(int id) async {
    try {
      await DioHelper.deleteDataWithAuth(
        url: EndPoints.deleteAgent(id),
        withAuth: true,
      );
      return true;
    } on DioException catch (e) {
      throw ServerException(ResponseParser.dioMessage(e));
    }
  }
}
