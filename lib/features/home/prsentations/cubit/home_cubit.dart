import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/home/domain/use_case/get_home_data_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeCubit(this.getHomeDataUseCase) : super(HomeInitial());

  Future<void> getHomeData({int? categoryID, String? search}) async {
    emit(HomeLoading());

    final result = await getHomeDataUseCase(
      categoryID: categoryID,
      search: search,
    );

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (home) => emit(HomeSuccess(home)),
    );
  }
}
