import 'property_agent_user_entity.dart';

class PropertyAgentEntity {
  final int id;
  final String title;
  final String? bio;
  final String? licenseNumber;
  final String? company;
  final PropertyAgentUserEntity? user;

  const PropertyAgentEntity({
    required this.id,
    required this.title,
    this.bio,
    this.licenseNumber,
    this.company,
    this.user,
  });
}
