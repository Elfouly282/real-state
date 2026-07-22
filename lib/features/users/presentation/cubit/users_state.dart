part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersActionLoading extends UsersState {}

class UsersSuccess extends UsersState {
  final List<UserEntity> list;
  final UserPaginationMeta meta;
  UsersSuccess(this.list, this.meta);
}

class UsersFailure extends UsersState {
  final String message;
  UsersFailure(this.message);
}

/// Emitted when a block/unblock action fails — does NOT replace the
/// current list (which has already been rolled back to [UsersSuccess]).
class UsersBlockFailure extends UsersState {
  final String message;
  UsersBlockFailure(this.message);
}
