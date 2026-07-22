import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.location,
    required super.role,
    required super.createdAt,
    super.isBlocked = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      role: json['role'] as String? ?? 'user',
      createdAt: json['created_at'] as String? ?? '',
      isBlocked: _parseBool(json['is_blocked']),
    );
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return false;
  }
}

class PaginatedUsersModel extends PaginatedUsersEntity {
  const PaginatedUsersModel({required super.data, required super.meta});

  factory PaginatedUsersModel.fromJson(dynamic raw) {
    final Map<String, dynamic> root;
    if (raw is List && raw.isNotEmpty) {
      root = raw[0] as Map<String, dynamic>;
    } else if (raw is Map<String, dynamic>) {
      root = raw;
    } else {
      return PaginatedUsersModel(
        data: [],
        meta: UserPaginationMeta(
            currentPage: 1, lastPage: 1, perPage: 30, total: 0),
      );
    }

    final dataList = root['data'] as List? ?? [];
    final metaMap = root['meta'] as Map<String, dynamic>? ?? {};

    return PaginatedUsersModel(
      data: dataList
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: UserPaginationMeta(
        currentPage: (metaMap['current_page'] as num?)?.toInt() ?? 1,
        lastPage: (metaMap['last_page'] as num?)?.toInt() ?? 1,
        perPage: (metaMap['per_page'] as num?)?.toInt() ?? 30,
        total: (metaMap['total'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
