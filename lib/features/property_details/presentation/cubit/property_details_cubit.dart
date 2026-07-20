import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_state/core/api/constant_API.dart';
import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';
import 'package:real_state/features/property_details/domain/use_case/get_property_details_usecase.dart';

part 'property_details_state.dart';

class PropertyDetailsCubit extends Cubit<PropertyDetailsState> {
  final GetPropertyDetailsUsecase getProperty;

  PropertyDetailsCubit({required this.getProperty})
    : super(PropertyDetailsInitial());

  Future<void> makeFav(int id) async {
    if (state is! PropertyDetailsLoadded) return;

    final currentState = state as PropertyDetailsLoadded;
    await DioHelper.postData(
      url: EndPoints.favorites,
      data: {'property_id': id},
      withAuth: true,
    );
    emit(
      PropertyDetailsLoadded(
        property: currentState.property,
        isFav: !currentState.isFav,
      ),
    );
  }

  Future<void> getPropertyDetails(int id) async {
    emit(PropertyDetailsLoadding());
    try {
      final property = await getProperty(id);
      emit(PropertyDetailsLoadded(property: property));
    } catch (e) {
      emit(propertyDetailsError(message: e.toString()));
    }
  }
}
