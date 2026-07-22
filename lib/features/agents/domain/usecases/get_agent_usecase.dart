import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';
import '../repositories/agents_repository.dart';

class GetAgentUsecase {
  final AgentsRepository _repo;
  GetAgentUsecase(this._repo);
  Future<Either<Failure, AgentEntity>> call(int id) => _repo.getAgent(id);
}
