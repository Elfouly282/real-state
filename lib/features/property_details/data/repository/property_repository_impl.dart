import 'package:real_state/features/property_details/data/data_sourse/property_details_remote_data_Sourse.dart';
import 'package:real_state/features/property_details/domain/entities/property_entity.dart';
import 'package:real_state/features/property_details/domain/repository/property_details_repo.dart';

class PropertyRepositoryImpl implements PropertyDetailsRepo {
  final PropertyDetailsRemoteDataSourse dataSourse;

  PropertyRepositoryImpl({required this.dataSourse});
  @override
  Future<PropertyEntity> getPropertyDetails(int id) {
    return dataSourse.getPropertyDetails(id);
  }
}
