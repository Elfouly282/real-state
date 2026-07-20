import 'package:real_state/features/user_reviews/domain/entites/User_reviews.dart';

class ReviewsEntity {
  final int id;
  final int rating;
  final String comment;
  final UserReviews user;

  ReviewsEntity({
    required this.id,
    required this.rating,
    required this.comment,
    required this.user,
  });
}
