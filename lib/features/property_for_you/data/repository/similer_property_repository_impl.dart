import 'package:real_state/features/property_for_you/data/data_sourse/similer_property_remote_data_sourse.dart';
import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';
import 'package:real_state/features/property_for_you/domain/repository/similer_property_repository.dart';

class SimilerPropertyRepositoryImpl implements SimilerPropertyRepository {
  final SimilerPropertyRemoteDataSourse remoteDataSourse;

  SimilerPropertyRepositoryImpl({required this.remoteDataSourse});
  @override
  Future<List<SimilerPropertyEntity>> getAllSimilerProperty(int id) {
    return remoteDataSourse.getAllSimilerProperty(id);
  }
}
