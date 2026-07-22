import 'package:real_state/features/user_reviews/data/data_sourse/reviews_remote_data_sourse.dart';
import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';
import 'package:real_state/features/user_reviews/domain/repository/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsRemoteDataSourse remoteDataSourse;

  ReviewsRepositoryImpl({required this.remoteDataSourse});
  @override
  Future<List<ReviewsEntity>> getAllReviews(int Property_id) {
    return remoteDataSourse.getAllReviews(Property_id);
  }
}
