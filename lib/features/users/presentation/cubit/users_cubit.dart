import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/users_usecases.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUsecase _get;
  final BlockUserUsecase _block;

  UsersCubit(this._get, this._block) : super(UsersInitial());

  Future<void> load({int page = 1}) async {
    // Keep current data visible during page change — only show full loading on first load.
    if (state is! UsersSuccess) emit(UsersLoading());
    final res = await _get(page: page);
    res.fold(
      (f) => emit(UsersFailure(f.message)),
      (paginated) => emit(UsersSuccess(paginated.data, paginated.meta)),
    );
  }

  Future<void> block(int id) async {
    final current = state;
    if (current is! UsersSuccess) return;

    // Guard: skip if user is not in current list
    final targetIndex = current.list.indexWhere((u) => u.id == id);
    if (targetIndex == -1) return;

    final newBlockedValue = !current.list[targetIndex].isBlocked;

    // Optimistic update — show toggle immediately
    final updated = current.list.map((u) {
      if (u.id == id) return u.copyWith(isBlocked: newBlockedValue);
      return u;
    }).toList();

    emit(UsersSuccess(updated, current.meta));

    final res = await _block(id, block: newBlockedValue);
    res.fold(
      (f) {
        // Rollback on failure + surface the error
        emit(UsersSuccess(current.list, current.meta));
        emit(UsersBlockFailure(f.message));
      },
      (_) {
        // API confirmed success — keep the optimistic state.
        // We do NOT reload from server because the API response
        // does not include is_blocked, so reloading would reset
        // all block states to false (null → false).
      },
    );
  }
}
