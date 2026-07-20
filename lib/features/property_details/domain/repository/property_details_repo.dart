import 'package:real_state/features/property_details/domain/entities/property_entity.dart';

abstract class PropertyDetailsRepo {
  Future<PropertyEntity> getPropertyDetails(int id);
}
