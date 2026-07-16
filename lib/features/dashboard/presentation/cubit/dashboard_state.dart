part of 'dashboard_cubit.dart';

abstract class DashboardState {}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardSuccess extends DashboardState {
  final DashboardEntity data;
  DashboardSuccess(this.data);
}
class DashboardFailure extends DashboardState {
  final String message;
  DashboardFailure(this.message);
}
