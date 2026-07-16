import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/agent_entity.dart';
import '../../domain/repositories/agents_repository.dart';
import '../datasources/agents_remote_datasource.dart';

class AgentsRepositoryImpl implements AgentsRepository {
  final AgentsRemoteDatasource _remote;
  final NetworkInfo _network;

  AgentsRepositoryImpl({required AgentsRemoteDatasource remote, required NetworkInfo network})
      : _remote = remote, _network = network;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() fn) async {
    if (!await _network.isConnected) return Left(NoInternetFailure(message: 'لا يوجد اتصال'));
    try { return Right(await fn()); }
    on ServerException catch (e) { return Left(ApiFailure(message: e.message)); }
    catch (e) { return Left(ServiceFailure(message: e.toString())); }
  }

  @override Future<Either<Failure, List<AgentEntity>>> getAgents() => _run(_remote.getAgents);
  @override Future<Either<Failure, AgentEntity>> getAgent(int id) => _run(() => _remote.getAgent(id));
  @override Future<Either<Failure, AgentEntity>> createAgent(Map<String, dynamic> data) => _run(() => _remote.createAgent(data));
  @override Future<Either<Failure, AgentEntity>> updateAgent(int id, Map<String, dynamic> data) => _run(() => _remote.updateAgent(id, data));
  @override Future<Either<Failure, bool>> deleteAgent(int id) => _run(() => _remote.deleteAgent(id));
}
