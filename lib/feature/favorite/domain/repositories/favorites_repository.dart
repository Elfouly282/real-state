import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/favorite/domain/entity/property_entity.dart';

abstract class FavoritesRepository {

  Future<Either<Failure, List<PropertyEntity>>> getFavorites();

  Future<Either<Failure, Unit>> toggleFavorite({required int propertyId});
}