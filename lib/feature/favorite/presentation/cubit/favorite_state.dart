part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoritesInitial extends FavoriteState {}

final class FavoritesLoading extends FavoriteState {}

final class FavoritesLoaded extends FavoriteState {
  final List<PropertyEntity> favorites;
  FavoritesLoaded({required this.favorites});
}

final class FavoritesError extends FavoriteState {
  final String message;
  FavoritesError({required this.message});
}
