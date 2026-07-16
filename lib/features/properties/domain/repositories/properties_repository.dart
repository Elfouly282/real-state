import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/property_entity.dart';

abstract class PropertiesRepository {
  Future<Either<Failure, List<PropertyEntity>>> getProperties();
  Future<Either<Failure, PropertyEntity>> getProperty(int id);
  Future<Either<Failure, PropertyEntity>> createProperty(Map<String, dynamic> data);
  Future<Either<Failure, PropertyEntity>> updateProperty(int id, Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteProperty(int id);
}
