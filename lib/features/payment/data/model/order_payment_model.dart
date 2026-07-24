import 'package:real_state/features/payment/domain/entity/order_payment_entity.dart';

class OrderPaymentModel extends OrderPaymentEntity {
  const OrderPaymentModel({required super.paymentUrl, required super.order});
  factory OrderPaymentModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    return OrderPaymentModel(
      paymentUrl: data['payment_url'] as String? ?? '',
      order: OrderModel.fromJson(data['order'] as Map<String, dynamic>? ?? {}),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'payment_url': paymentUrl,
      'order': order is OrderModel ? (order as OrderModel).toJson() : null,
    };
  }

  //toEntity()
  OrderPaymentEntity toEntity() => this;
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.amount,
    required super.currency,
    required super.status,
    super.stripeCheckoutSessionId,
    super.createdAt,
    super.property,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] as num).toInt(),
      amount: json['amount']?.toString() ?? '',
      currency: json['currency'] as String? ?? '',
      status: json['status'] as String? ?? '',
      stripeCheckoutSessionId: json['stripe_checkout_session_id'] as String?,
      createdAt: json['created_at'] as String?,
      property: json['property'] is Map<String, dynamic>
          ? OrderPropertyModel.fromJson(
              json['property'] as Map<String, dynamic>,
            )
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'status': status,
      'stripe_checkout_session_id': stripeCheckoutSessionId,
      'created_at': createdAt,
      'property': property is OrderPropertyModel
          ? (property as OrderPropertyModel).toJson()
          : null,
    };
  }

  //toEntity()
  OrderEntity toEntity() => this;
}

class OrderPropertyModel extends OrderPropertyEntity {
  const OrderPropertyModel({
    required super.id,
    required super.title,
    required super.price,
    super.slug,
    super.description,
    super.listingType,
    super.status,
    super.bedrooms,
    super.bathrooms,
    super.kitchens,
    super.isFeatured,
    super.salesCount,
    super.latitude,
    super.longitude,
    super.address,
  });
  factory OrderPropertyModel.fromJson(Map<String, dynamic> json) {
    return OrderPropertyModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      price: json['price'] as String? ?? '',
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      listingType: json['listing_type'] as String?,
      status: json['status'] as String?,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      kitchens: json['kitchens'] as int?,
      isFeatured: json['is_featured'] as bool?,
      salesCount: json['sales_count'] as int?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      address: json['address'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'slug': slug,
      'description': description,
      'listing_type': listingType,
      'status': status,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'kitchens': kitchens,
      'is_featured': isFeatured,
      'sales_count': salesCount,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  //toEntity()
  OrderPropertyEntity toEntity() => this;
}
