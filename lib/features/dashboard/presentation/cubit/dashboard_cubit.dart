import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardUsecase _usecase;
  DashboardCubit(this._usecase) : super(DashboardInitial());

  Future<void> load() async {
    emit(DashboardLoading());
    final res = await _usecase();
    res.fold((f) => emit(DashboardFailure(f.message)), (d) => emit(DashboardSuccess(d)));
  }
}
