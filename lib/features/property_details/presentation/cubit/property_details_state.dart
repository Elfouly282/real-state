part of 'property_details_cubit.dart';

@immutable
sealed class PropertyDetailsState {}

final class PropertyDetailsInitial extends PropertyDetailsState {}

final class PropertyDetailsLoadding extends PropertyDetailsState {}

final class PropertyDetailsLoadded extends PropertyDetailsState {
  final PropertyEntity property;
  final bool isFav;

  PropertyDetailsLoadded({required this.property, this.isFav = false});
}

final class propertyDetailsError extends PropertyDetailsState {
  final String message;

  propertyDetailsError({required this.message});
}
