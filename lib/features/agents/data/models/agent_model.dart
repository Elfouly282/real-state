import '../../domain/entities/agent_entity.dart';

class AgentModel extends AgentEntity {
  const AgentModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.image,
    required super.propertiesCount,
    required super.createdAt,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      propertiesCount: (json['properties_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
