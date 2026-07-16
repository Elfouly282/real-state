import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/users_usecases.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUsecase _get;
  final BlockUserUsecase _block;

  UsersCubit(this._get, this._block) : super(UsersInitial());

  Future<void> load() async {
    emit(UsersLoading());
    final res = await _get();
    res.fold((f) => emit(UsersFailure(f.message)), (list) => emit(UsersSuccess(list)));
  }

  Future<void> block(int id) async {
    emit(UsersActionLoading());
    final res = await _block(id);
    res.fold((f) => emit(UsersFailure(f.message)), (_) => load());
  }
}
