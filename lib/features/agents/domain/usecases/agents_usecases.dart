import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';
import '../repositories/agents_repository.dart';

class GetAgentsUsecase {
  final AgentsRepository _repo;
  GetAgentsUsecase(this._repo);
  Future<Either<Failure, List<AgentEntity>>> call() => _repo.getAgents();
}

class GetAgentUsecase {
  final AgentsRepository _repo;
  GetAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(int id) => _repo.getAgent(id);
}

class CreateAgentUsecase {
  final AgentsRepository _repo;
  CreateAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(Map<String, dynamic> data) => _repo.createAgent(data);
}

class UpdateAgentUsecase {
  final AgentsRepository _repo;
  UpdateAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(int id, Map<String, dynamic> data) => _repo.updateAgent(id, data);
}

class DeleteAgentUsecase {
  final AgentsRepository _repo;
  DeleteAgentUsecase(this._repo);
  Future<Either<Failure, bool>> call(int id) => _repo.deleteAgent(id);
}
