import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:real_state/feature/favorite/domain/entity/property_entity.dart';
import 'package:real_state/feature/favorite/domain/usecases/get_favorites_usecase.dart';
import 'package:real_state/feature/favorite/domain/usecases/toggle_favorite_usecase.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  List<PropertyEntity> _favoritesList = [];

  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial());

  // Fetch favorites list from server
  Future<void> getFavorites() async {
    emit(FavoritesLoading());

    final result = await getFavoritesUseCase();

    result.fold((failure) => emit(FavoritesError(message: failure.message)), (
      items,
    ) {
      _favoritesList = items;
      emit(FavoritesLoaded(favorites: List.from(_favoritesList)));
    });
  }

  Future<void> toggleFavorite(PropertyEntity property) async {
    final index = _favoritesList.indexWhere(
      (element) => element.id == property.id,
    );
    final bool isCurrentlyFavorite = index != -1;

    if (isCurrentlyFavorite) {
      _favoritesList.removeAt(index);
    } else {
      _favoritesList.add(property);
    }
    emit(FavoritesLoaded(favorites: List.from(_favoritesList)));

    final result = await toggleFavoriteUseCase(propertyId: property.id);

    result.fold((failure) {
      if (isCurrentlyFavorite) {
        _favoritesList.insert(index, property);
      } else {
        _favoritesList.removeWhere((e) => e.id == property.id);
      }
      emit(FavoritesLoaded(favorites: List.from(_favoritesList)));
      emit(FavoritesError(message: failure.message));
    }, (_) {});
  }
}
