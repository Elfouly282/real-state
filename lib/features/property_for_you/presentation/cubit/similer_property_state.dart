part of 'similer_property_cubit.dart';

@immutable
sealed class SimilerPropertyState {}

final class SimilerPropertyInitial extends SimilerPropertyState {}

final class SimilerPropertyLoading extends SimilerPropertyState {}

final class SimilerPropertyLoaded extends SimilerPropertyState {
  final List<SimilerPropertyEntity> similerPropertyEntity;

  SimilerPropertyLoaded({required this.similerPropertyEntity});
}

final class SimilerPropertyError extends SimilerPropertyState {
  final String message;

  SimilerPropertyError({required this.message});
}
