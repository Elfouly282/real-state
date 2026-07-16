import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/usecases/properties_usecases.dart';
part 'properties_state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  final GetPropertiesUsecase _get;
  final DeletePropertyUsecase _delete;

  PropertiesCubit(this._get, this._delete) : super(PropertiesInitial());

  Future<void> load() async {
    emit(PropertiesLoading());
    final res = await _get();
    res.fold((f) => emit(PropertiesFailure(f.message)), (list) => emit(PropertiesSuccess(list)));
  }

  Future<void> delete(int id) async {
    emit(PropertiesActionLoading());
    final res = await _delete(id);
    res.fold((f) => emit(PropertiesFailure(f.message)), (_) => load());
  }
}
