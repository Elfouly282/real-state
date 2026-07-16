part of 'users_cubit.dart';

abstract class UsersState {}
class UsersInitial extends UsersState {}
class UsersLoading extends UsersState {}
class UsersActionLoading extends UsersState {}
class UsersSuccess extends UsersState {
  final List<UserEntity> list;
  UsersSuccess(this.list);
}
class UsersFailure extends UsersState {
  final String message;
  UsersFailure(this.message);
}
