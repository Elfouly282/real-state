class PropertyEntity {
  final int id;
  final String title;
  final String? description;
  final double price;
  final String status;
  final String? type;
  final String? city;
  final String? imageUrl;
  final int? categoryId;
  final int? agentId;
  final String createdAt;

  const PropertyEntity({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    required this.status,
    this.type,
    this.city,
    this.imageUrl,
    this.categoryId,
    this.agentId,
    required this.createdAt,
  });
}
