class OrderEntity {
  final int id;
  final String status;
  final double totalPrice;
  final int userId;
  final String userName;
  final int propertyId;
  final String propertyTitle;
  final String createdAt;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.userId,
    required this.userName,
    required this.propertyId,
    required this.propertyTitle,
    required this.createdAt,
  });
}
