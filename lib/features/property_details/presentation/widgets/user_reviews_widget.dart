import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/user_reviews/presentation/cubit/user_reviews_cubit.dart';
import 'package:real_state/features/user_reviews/presentation/widget/reviews_card.dart';

class UserReviewsWidget extends StatelessWidget {
  const UserReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserReviewsCubit, UserReviewsState>(
      builder: (context, state) {
        if (state is UserReviewsLoading) {
          return const ReviewsCard();
        }

        if (state is UserReviewLoaded) {
          if (state.reviewsEntity.isEmpty) {
            return const Text("No Reviews");
          }

          return ReviewsCard(review: state.reviewsEntity.first);
        }

        if (state is UserReviewsError) {
          return Text(state.message);
        }

        return const SizedBox();
      },
    );
  }
}
