import 'package:real_state/features/property_for_you/domain/Entites/similer_ptoperty_entity.dart';
import 'package:real_state/features/property_for_you/domain/repository/similer_property_repository.dart';

class similerPropertyUserCase {
  final SimilerPropertyRepository repo;

  similerPropertyUserCase({required this.repo});
  Future<List<SimilerPropertyEntity>> call(int id) {
    return repo.getAllSimilerProperty(id);
  }
}
