import 'package:real_state/features/property_details/data/models/property_agent_user_model.dart';
import 'package:real_state/features/property_details/domain/entities/property_agent_entity.dart';

class PropertyAgentModel extends PropertyAgentEntity {
  PropertyAgentModel({required super.title, required super.user});
  factory PropertyAgentModel.fromJson(Map<String, dynamic> json) {
    return PropertyAgentModel(
      title: json['title'],
      user: PropertyAgentUserModel.fromJson(json['user']),
    );
  }
}
