import 'package:real_state/features/home/domain/entity/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name);
  }
}
