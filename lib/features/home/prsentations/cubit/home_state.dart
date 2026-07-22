import 'package:real_state/features/home/domain/entity/home_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeEntity home;

  HomeSuccess(this.home);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
