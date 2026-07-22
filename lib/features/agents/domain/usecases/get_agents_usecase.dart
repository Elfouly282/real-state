import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/agent_entity.dart';
import '../repositories/agents_repository.dart';

class GetAgentsUsecase {
  final AgentsRepository _repo;
  GetAgentsUsecase(this._repo);
  Future<Either<Failure, PaginatedAgentsEntity>> call({int perPage = 50, int page = 1}) =>
      _repo.getAgents(perPage: perPage, page: page);
}
