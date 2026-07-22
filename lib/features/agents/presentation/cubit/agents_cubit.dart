import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/agent_entity.dart';
import '../../domain/usecases/agents_usecases.dart';
part 'agents_state.dart';

class AgentsCubit extends Cubit<AgentsState> {
  final GetAgentsUsecase _get;
  final DeleteAgentUsecase _delete;

  AgentsCubit(this._get, this._delete) : super(AgentsInitial());

  Future<void> load({int page = 1}) async {
    if (state is! AgentsSuccess) emit(AgentsLoading());
    final res = await _get(page: page);
    res.fold(
      (f) => emit(AgentsFailure(f.message)),
      (paginated) => emit(AgentsSuccess(paginated.data, paginated.meta)),
    );
  }

  Future<void> delete(int id) async {
    emit(AgentsActionLoading());
    final res = await _delete(id);
    await res.fold(
      (f) async => emit(AgentsFailure(f.message)),
      (_) async => load(),
    );
  }
}
