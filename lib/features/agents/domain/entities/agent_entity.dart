class AgentEntity {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? image;
  final int propertiesCount;
  final String createdAt;

  const AgentEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.image,
    required this.propertiesCount,
    required this.createdAt,
  });
}
