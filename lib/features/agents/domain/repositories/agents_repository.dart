import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';

abstract class AgentsRepository {
  Future<Either<Failure, List<AgentEntity>>> getAgents();
  Future<Either<Failure, AgentEntity>> getAgent(int id);
  Future<Either<Failure, AgentEntity>> createAgent(Map<String, dynamic> data);
  Future<Either<Failure, AgentEntity>> updateAgent(int id, Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteAgent(int id);
}
