import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/agents_repository.dart';

class DeleteAgentUsecase {
  final AgentsRepository _repo;
  DeleteAgentUsecase(this._repo);
  Future<Either<Failure, bool>> call(int id) => _repo.deleteAgent(id);
}
