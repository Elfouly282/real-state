class CreateAgentParams {
  final int userId;
  final String title;
  final String? bio;
  final String? licenseNumber;
  final String? company;

  const CreateAgentParams({
    required this.userId,
    required this.title,
    this.bio,
    this.licenseNumber,
    this.company,
  });
}

class AgentUserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;
  final String createdAt;

  const AgentUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.phone,
    required this.createdAt,
  });
}

class AgentEntity {
  final int id;
  final String title;
  final String? bio;
  final String? licenseNumber;
  final String? company;
  final AgentUserEntity? user;

  const AgentEntity({
    required this.id,
    required this.title,
    this.bio,
    this.licenseNumber,
    this.company,
    this.user,
  });

  String get name => user?.name ?? title;
  String get email => user?.email ?? '';
}

class AgentPaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const AgentPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

class PaginatedAgentsEntity {
  final List<AgentEntity> data;
  final AgentPaginationMeta meta;

  const PaginatedAgentsEntity({
    required this.data,
    required this.meta,
  });
}
