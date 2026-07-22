import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';
import '../repositories/agents_repository.dart';

class UpdateAgentUsecase {
  final AgentsRepository _repo;
  UpdateAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(int id, CreateAgentParams params) =>
      _repo.updateAgent(id, params);
}
