import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/property_entity.dart';
import '../repositories/properties_repository.dart';

class GetPropertiesUsecase {
  final PropertiesRepository _repo;
  GetPropertiesUsecase(this._repo);
  Future<Either<Failure, List<PropertyEntity>>> call() => _repo.getProperties();
}

class GetPropertyUsecase {
  final PropertiesRepository _repo;
  GetPropertyUsecase(this._repo);
  Future<Either<Failure, PropertyEntity>> call(int id) => _repo.getProperty(id);
}

class CreatePropertyUsecase {
  final PropertiesRepository _repo;
  CreatePropertyUsecase(this._repo);
  Future<Either<Failure, PropertyEntity>> call(Map<String, dynamic> data) => _repo.createProperty(data);
}

class UpdatePropertyUsecase {
  final PropertiesRepository _repo;
  UpdatePropertyUsecase(this._repo);
  Future<Either<Failure, PropertyEntity>> call(int id, Map<String, dynamic> data) => _repo.updateProperty(id, data);
}

class DeletePropertyUsecase {
  final PropertiesRepository _repo;
  DeletePropertyUsecase(this._repo);
  Future<Either<Failure, bool>> call(int id) => _repo.deleteProperty(id);
}
