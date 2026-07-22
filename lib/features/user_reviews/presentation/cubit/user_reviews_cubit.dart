import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';
import 'package:real_state/features/user_reviews/domain/use_case/reviews_use_case.dart';

part 'user_reviews_state.dart';

class UserReviewsCubit extends Cubit<UserReviewsState> {
  final ReviewsUseCase getReviews;
  UserReviewsCubit({required this.getReviews}) : super(UserReviewsInitial());
  Future<void> getAllReviwes(int property_id) async {
    emit(UserReviewsLoading());
    try {
      final reviews = await getReviews(property_id);
      emit(UserReviewLoaded(reviewsEntity: reviews));
    } catch (e) {
      emit(UserReviewsError(message: e.toString()));
    }
  }
}
