import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.status,
    required super.totalPrice,
    required super.userId,
    required super.userName,
    required super.propertyId,
    required super.propertyTitle,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    final property = json['property'] as Map<String, dynamic>? ?? {};
    return OrderModel(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String? ?? '',
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0,
      userId: (user['id'] as num?)?.toInt() ?? 0,
      userName: user['name'] as String? ?? '',
      propertyId: (property['id'] as num?)?.toInt() ?? 0,
      propertyTitle: property['title'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
