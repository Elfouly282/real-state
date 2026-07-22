import 'package:dio/dio.dart';

class CreatePropertyParams {
  final int categoryId;
  final int assignedAgentId;
  final String title;
  final String? description;
  final String price;
  final String listingType;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final String status;
  final int isFeatured;
  final String? address;
  final String? latitude;
  final String? longitude;
  final List<MultipartFile> images;

  const CreatePropertyParams({
    required this.categoryId,
    required this.assignedAgentId,
    required this.title,
    this.description,
    required this.price,
    required this.listingType,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.status,
    this.isFeatured = 0,
    this.address,
    this.latitude,
    this.longitude,
    this.images = const [],
  });
}
