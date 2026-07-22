import 'package:real_state/core/api/constant_API.dart';
import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/features/property_details/data/models/property_details_model.dart';

class PropertyDetailsRemoteDataSourse {
  Future<PropertyDetailsModel> getPropertyDetails(int id) async {
    final response = await DioHelper.getData(
      url: EndPoints.propertyById(id),
      withAuth: true,
    );
    return PropertyDetailsModel.fromJson(response.data);
  }
}
