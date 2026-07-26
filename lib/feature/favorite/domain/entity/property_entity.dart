class PropertyEntity {
  final int id;
  final String title;
  final String price;
  final String address;
  final double rate;
  final List<String> imageUrls;
  bool isFavorite;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.address,
    required this.rate,
    required this.imageUrls,
    this.isFavorite = true,
  });
}