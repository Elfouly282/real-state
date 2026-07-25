

import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.location,
    required super.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
  
    final data = json['data'] ?? json;
    
    return ProfileModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'location': location,
      'phone': phone,
    };
  }
}