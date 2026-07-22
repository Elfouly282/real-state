import 'package:real_state/features/property_details/domain/entities/property_entity.dart';
import 'package:real_state/features/property_details/domain/repository/property_details_repo.dart';

class GetPropertyDetailsUsecase {
  final PropertyDetailsRepo repo;

  GetPropertyDetailsUsecase({required this.repo});

  Future<PropertyEntity> call(int id) {
    return repo.getPropertyDetails(id);
  }
}
