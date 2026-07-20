import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';

abstract class SimilerPropertyRepository {
  Future<List<SimilerPropertyEntity>> getAllSimilerProperty(int id);
}
