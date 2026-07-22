import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/repositories/properties_repository.dart';
import '../datasources/properties_remote_datasource.dart';

class PropertiesRepositoryImpl implements PropertiesRepository {
  final PropertiesRemoteDatasource _remote;
  final NetworkInfo _network;

  PropertiesRepositoryImpl({
    required PropertiesRemoteDatasource remote,
    required NetworkInfo network,
  })  : _remote = remote,
        _network = network;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() fn) async {
    if (!await _network.isConnected) {
      return Left(NoInternetFailure(message: 'No Internet Connection'));
    }
    try {
      return Right(await fn());
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PropertyEntity>>> getProperties({int perPage = 20}) =>
      _run(() => _remote.getProperties(perPage: perPage));

  @override
  Future<Either<Failure, PropertyEntity>> getProperty(int id) =>
      _run(() => _remote.getProperty(id));

  @override
  Future<Either<Failure, PropertyEntity>> createProperty(CreatePropertyParams params) =>
      _run(() => _remote.createProperty(params));

  @override
  Future<Either<Failure, PropertyEntity>> updateProperty(int id, CreatePropertyParams params) =>
      _run(() => _remote.updateProperty(id, params));

  @override
  Future<Either<Failure, bool>> deleteProperty(int id) =>
      _run(() => _remote.deleteProperty(id));
}
