part of 'user_reviews_cubit.dart';

@immutable
sealed class UserReviewsState {}

final class UserReviewsInitial extends UserReviewsState {}

final class UserReviewsLoading extends UserReviewsState {}

final class UserReviewLoaded extends UserReviewsState {
  final List<ReviewsEntity> reviewsEntity;

  UserReviewLoaded({required this.reviewsEntity});
}

final class UserReviewsError extends UserReviewsState {
  final String message;

  UserReviewsError({required this.message});
}
