import 'package:real_state/features/user_reviews/data/models/user_reviwe_model.dart';
import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';

class ReviewsModel extends ReviewsEntity {
  ReviewsModel({
    required super.id,
    required super.rating,
    required super.comment,
    required super.user,
  });
  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      user: UserReviweModel.fromJson(json['user']),
    );
  }
}
