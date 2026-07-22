import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';

abstract class AgentsRepository {
  Future<Either<Failure, PaginatedAgentsEntity>> getAgents({int perPage = 50, int page = 1});
  Future<Either<Failure, AgentEntity>> getAgent(int id);
  Future<Either<Failure, AgentEntity>> createAgent(CreateAgentParams params);
  Future<Either<Failure, AgentEntity>> updateAgent(int id, CreateAgentParams params);
  Future<Either<Failure, bool>> deleteAgent(int id);
}
