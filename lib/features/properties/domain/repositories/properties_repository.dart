import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/property_entity.dart';

abstract class PropertiesRepository {
  Future<Either<Failure, List<PropertyEntity>>> getProperties({int perPage = 20});
  Future<Either<Failure, PropertyEntity>> getProperty(int id);
  Future<Either<Failure, PropertyEntity>> createProperty(CreatePropertyParams params);
  Future<Either<Failure, PropertyEntity>> updateProperty(int id, CreatePropertyParams params);
  Future<Either<Failure, bool>> deleteProperty(int id);
}
