class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? location;
  final String role;
  final String createdAt;
  final bool isBlocked;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.location,
    required this.role,
    required this.createdAt,
    this.isBlocked = false,
  });

  UserEntity copyWith({bool? isBlocked, bool clearIsBlocked = false}) => UserEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        location: location,
        role: role,
        createdAt: createdAt,
        isBlocked: clearIsBlocked ? false : (isBlocked ?? this.isBlocked),
      );
}

class UserPaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const UserPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

class PaginatedUsersEntity {
  final List<UserEntity> data;
  final UserPaginationMeta meta;

  const PaginatedUsersEntity({
    required this.data,
    required this.meta,
  });
}
