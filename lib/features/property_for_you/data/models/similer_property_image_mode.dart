import 'package:real_state/features/property_for_you/domain/Entites/similer_property_image_entity.dart';

class SimilerPropertyImageMode extends SimilerPropertyImageEntity {
  SimilerPropertyImageMode({
    required super.id,
    required super.image,
    required super.Sort_order,
  });
  factory SimilerPropertyImageMode.fromJson(Map<String, dynamic> json) {
    return SimilerPropertyImageMode(
      id: json['id'],
      image: json['url'],
      Sort_order: 0,
    );
  }
}
