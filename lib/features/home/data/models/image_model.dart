import 'package:real_state/features/home/domain/entity/image_entity.dart';

class ImageModel {
  final int id;
  final String url;

  ImageModel({required this.id, required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }

  ImageEntity toEntity() {
    return ImageEntity(id: id, url: url);
  }
}
