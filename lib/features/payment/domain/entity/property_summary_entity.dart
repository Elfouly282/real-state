import 'package:equatable/equatable.dart';

class PropertySummaryEntity extends Equatable {
  final int id;
  final String title;
  final String address;
  final String imageUrl; 
  final String price;
  final String reviews;
  final double rate;
  final String description;
  final String appointmentDate;

  const PropertySummaryEntity({
    required this.id,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.description,
    required this.reviews,
    required this.appointmentDate,
  });

  double get numericPrice => double.tryParse(price) ?? 0.0;

  double get taxPercentage => 0.002083;

  double get serviceFee => numericPrice * taxPercentage;

  double get totalPrice => numericPrice + serviceFee;

  @override
  List<Object?> get props => [
    id,
    title,
    address,
    imageUrl,
    price,
    rate,
    description,
  ];
}
