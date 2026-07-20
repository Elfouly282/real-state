import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';
import 'package:real_state/features/user_reviews/domain/repository/reviews_repository.dart';

class ReviewsUseCase {
  final ReviewsRepository repo;

  ReviewsUseCase({required this.repo});

  Future<List<ReviewsEntity>> call(int Property_id) {
    return repo.getAllReviews(Property_id);
  }
}
