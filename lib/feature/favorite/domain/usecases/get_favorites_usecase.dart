import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/favorite/domain/entity/property_entity.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<Either<Failure, List<PropertyEntity>>> call() async {
    return await repository.getFavorites();
  }
}