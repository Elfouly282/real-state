import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';
import 'package:real_state/features/property_for_you/domain/use_case/similer_property_Use_case.dart';

part 'similer_property_state.dart';

class SimilerPropertyCubit extends Cubit<SimilerPropertyState> {
  final similerPropertyUserCase getsimilerProperty;
  SimilerPropertyCubit({required this.getsimilerProperty})
    : super(SimilerPropertyInitial());
  Future<void> getSimilerProperty(int id) async {
    emit(SimilerPropertyLoading());
    try {
      print('😂before');
      final similerProperty = await getsimilerProperty(id);
      print("after request");
      print(similerProperty.length);
      emit(SimilerPropertyLoaded(similerPropertyEntity: similerProperty));
    } catch (e, s) {
      print(e);
      print(s);
      emit(SimilerPropertyError(message: e.toString()));
    }
  }
}
