import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';
import '../repositories/agents_repository.dart';

class CreateAgentUsecase {
  final AgentsRepository _repo;
  CreateAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(CreateAgentParams params) =>
      _repo.createAgent(params);
}
