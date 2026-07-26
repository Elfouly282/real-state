import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';

import '../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required int propertyId}) async {
    return await repository.toggleFavorite(propertyId: propertyId);
  }
}