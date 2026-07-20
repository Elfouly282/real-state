import 'package:real_state/core/api/constant_API.dart';
import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/features/property_for_you/data/models/similer_property_model.dart';

class SimilerPropertyRemoteDataSourse {
  Future<List<SimilerPropertyModel>> getAllSimilerProperty(int id) async {
    print('1');
    final response = await DioHelper.getData(
      url: EndPoints.similarProperties(id),
      withAuth: true,
    );
    print(response.data);
    return (response.data['data'] as List)
        .map((e) => SimilerPropertyModel.fromJson(e))
        .toList();
  }
}
