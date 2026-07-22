import '../../../properties/domain/entities/property_entity.dart';

class OrderUserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? phone;
  final String createdAt;

  const OrderUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.phone,
    required this.createdAt,
  });
}

class OrderEntity {
  final int id;
  final double amount;
  final String currency;
  final String status;
  final String? stripeCheckoutSessionId;
  final String createdAt;
  final OrderUserEntity? user;
  final PropertyEntity? property;

  const OrderEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    this.stripeCheckoutSessionId,
    required this.createdAt,
    this.user,
    this.property,
  });
}

class OrderPaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const OrderPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });
}

class PaginatedOrdersEntity {
  final List<OrderEntity> data;
  final OrderPaginationMeta meta;

  const PaginatedOrdersEntity({
    required this.data,
    required this.meta,
  });
}
