import 'package:real_state/features/property_details/domain/entities/property_agent_user_entity.dart';

class PropertyAgentUserModel extends PropertyAgentUserEntity {
  PropertyAgentUserModel({required super.id, required super.name});
  factory PropertyAgentUserModel.fromJson(Map<String, dynamic> json) {
    return PropertyAgentUserModel(id: json['id'], name: json['name']);
  }
}
