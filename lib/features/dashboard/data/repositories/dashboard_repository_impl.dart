import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource _remote;
  final NetworkInfo _network;

  DashboardRepositoryImpl({required DashboardRemoteDatasource remote, required NetworkInfo network})
      : _remote = remote, _network = network;

  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() async {
    if (!await _network.isConnected) return Left(NoInternetFailure(message: 'No Connection'));
    try { return Right(await _remote.getDashboard()); }
    on ServerException catch (e) { return Left(ApiFailure(message: e.message)); }
    catch (e) { return Left(ServiceFailure(message: e.toString())); }
  }
}
