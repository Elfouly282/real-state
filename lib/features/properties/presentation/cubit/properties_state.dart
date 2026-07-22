part of 'properties_cubit.dart';

abstract class PropertiesState {}

class PropertiesInitial extends PropertiesState {}

class PropertiesLoading extends PropertiesState {}

class PropertiesActionLoading extends PropertiesState {}

class PropertiesSuccess extends PropertiesState {
  final List<PropertyEntity> list;
  PropertiesSuccess(this.list);
}

class PropertiesFailure extends PropertiesState {
  final String message;
  PropertiesFailure(this.message);
}
