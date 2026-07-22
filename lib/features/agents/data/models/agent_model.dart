import '../../domain/entities/agent_entity.dart';

class AgentUserModel extends AgentUserEntity {
  const AgentUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.location,
    super.phone,
    required super.createdAt,
  });

  factory AgentUserModel.fromJson(Map<String, dynamic> json) {
    return AgentUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}

class AgentModel extends AgentEntity {
  const AgentModel({
    required super.id,
    required super.title,
    super.bio,
    super.licenseNumber,
    super.company,
    super.user,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    final userRaw = json['user'];
    AgentUserModel? user;
    if (userRaw is List && userRaw.isNotEmpty) {
      user = AgentUserModel.fromJson(userRaw[0] as Map<String, dynamic>);
    } else if (userRaw is Map<String, dynamic>) {
      user = AgentUserModel.fromJson(userRaw);
    }

    return AgentModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      bio: json['bio'] as String?,
      licenseNumber: json['license_number'] as String?,
      company: json['company'] as String?,
      user: user,
    );
  }
}

class PaginatedAgentsModel extends PaginatedAgentsEntity {
  const PaginatedAgentsModel({
    required super.data,
    required super.meta,
  });

  factory PaginatedAgentsModel.fromJson(dynamic raw) {
    final Map<String, dynamic> root;
    if (raw is List && raw.isNotEmpty) {
      root = raw[0] as Map<String, dynamic>;
    } else if (raw is Map<String, dynamic>) {
      root = raw;
    } else {
      return PaginatedAgentsModel(
        data: [],
        meta: AgentPaginationMeta(
            currentPage: 1, lastPage: 1, perPage: 50, total: 0),
      );
    }

    final dataList = root['data'] as List? ?? [];
    final metaMap = root['meta'] as Map<String, dynamic>? ?? {};

    return PaginatedAgentsModel(
      data: dataList
          .map((e) => AgentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: AgentPaginationMeta(
        currentPage: (metaMap['current_page'] as num?)?.toInt() ?? 1,
        lastPage: (metaMap['last_page'] as num?)?.toInt() ?? 1,
        perPage: (metaMap['per_page'] as num?)?.toInt() ?? 50,
        total: (metaMap['total'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
