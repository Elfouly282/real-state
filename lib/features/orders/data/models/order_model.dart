import '../../../properties/data/models/property_model.dart';
import '../../domain/entities/order_entity.dart';

class OrderUserModel extends OrderUserEntity {
  const OrderUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.location,
    super.phone,
    required super.createdAt,
  });

  factory OrderUserModel.fromJson(Map<String, dynamic> json) {
    return OrderUserModel(
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

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.amount,
    required super.currency,
    required super.status,
    super.stripeCheckoutSessionId,
    required super.createdAt,
    super.user,
    super.property,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final userRaw = json['user'];
    OrderUserModel? user;
    if (userRaw is Map<String, dynamic>) {
      user = OrderUserModel.fromJson(userRaw);
    } else if (userRaw is List && userRaw.isNotEmpty) {
      user = OrderUserModel.fromJson(userRaw[0] as Map<String, dynamic>);
    }

    final propRaw = json['property'];
    PropertyModel? property;
    if (propRaw is Map<String, dynamic>) {
      property = PropertyModel.fromJson(propRaw);
    } else if (propRaw is List && propRaw.isNotEmpty) {
      property = PropertyModel.fromJson(propRaw[0] as Map<String, dynamic>);
    }

    return OrderModel(
      id: (json['id'] as num).toInt(),
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      currency: json['currency'] as String? ?? 'usd',
      status: json['status'] as String? ?? '',
      stripeCheckoutSessionId: json['stripe_checkout_session_id'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      user: user,
      property: property,
    );
  }
}

class PaginatedOrdersModel extends PaginatedOrdersEntity {
  const PaginatedOrdersModel({required super.data, required super.meta});

  factory PaginatedOrdersModel.fromJson(dynamic raw) {
    final Map<String, dynamic> root;
    if (raw is List && raw.isNotEmpty) {
      root = raw[0] as Map<String, dynamic>;
    } else if (raw is Map<String, dynamic>) {
      root = raw;
    } else {
      return PaginatedOrdersModel(
        data: [],
        meta: OrderPaginationMeta(
            currentPage: 1, lastPage: 1, perPage: 30, total: 0),
      );
    }

    final dataList = root['data'] as List? ?? [];
    final metaMap = root['meta'] as Map<String, dynamic>? ?? {};

    return PaginatedOrdersModel(
      data: dataList
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: OrderPaginationMeta(
        currentPage: (metaMap['current_page'] as num?)?.toInt() ?? 1,
        lastPage: (metaMap['last_page'] as num?)?.toInt() ?? 1,
        perPage: (metaMap['per_page'] as num?)?.toInt() ?? 30,
        total: (metaMap['total'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}
