import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';

abstract class ReviewsRepository {
  Future<List<ReviewsEntity>> getAllReviews(int Property_id);
}
