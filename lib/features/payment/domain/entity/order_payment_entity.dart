import 'package:equatable/equatable.dart';

class OrderPaymentEntity extends Equatable {
  final String paymentUrl;
  final OrderEntity order;

  const OrderPaymentEntity({required this.paymentUrl, required this.order});

  @override
  List<Object?> get props => [paymentUrl, order];
}

class OrderEntity extends Equatable {
  final int id;
  final String amount;
  final String currency;
  final String status;
  final String? stripeCheckoutSessionId;
  final String? createdAt;
  final OrderPropertyEntity? property;

  const OrderEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    this.stripeCheckoutSessionId,
    this.createdAt,
    this.property,
  });

  @override
  List<Object?> get props => [
    id,
    amount,
    currency,
    status,
    stripeCheckoutSessionId,
    createdAt,
    property,
  ];
}

class OrderPropertyEntity extends Equatable {
  final int id;
  final String title;
  final String? slug;
  final String? description;
  final String price;
  final String? listingType;
  final String? status;
  final int? bedrooms;
  final int? bathrooms;
  final int? kitchens;
  final bool? isFeatured;
  final int? salesCount;
  final double? latitude;
  final double? longitude;
  final String? address;

  const OrderPropertyEntity({
    required this.id,
    required this.title,
    required this.price,
    this.slug,
    this.description,
    this.listingType,
    this.status,
    this.bedrooms,
    this.bathrooms,
    this.kitchens,
    this.isFeatured,
    this.salesCount,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    price,
    listingType,
    status,
    bedrooms,
    bathrooms,
    kitchens,
    isFeatured,
    salesCount,
    latitude,
    longitude,
    address,
  ];
}
