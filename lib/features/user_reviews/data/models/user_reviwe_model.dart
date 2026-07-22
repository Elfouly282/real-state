import 'package:real_state/features/user_reviews/domain/entites/User_reviews.dart';

class UserReviweModel extends UserReviews {
  UserReviweModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory UserReviweModel.fromJson(Map<String, dynamic> json) {
    return UserReviweModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
