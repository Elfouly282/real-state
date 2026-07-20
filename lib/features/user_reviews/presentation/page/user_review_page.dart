import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/user_reviews/presentation/cubit/user_reviews_cubit.dart';
import 'package:real_state/features/user_reviews/presentation/widget/reviews_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserReviewPage extends StatelessWidget {
  const UserReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            backgroundColor: Colors.black38,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.black38,
              child: Icon(Icons.notifications_active, color: Colors.white),
            ),
          ),
        ],
        title: Text(
          'User Reviews',
          style: getMediumStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: BlocBuilder<UserReviewsCubit, UserReviewsState>(
        builder: ((context, state) {
          if (state is UserReviewsLoading) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, _) => const ReviewsCard(),
              ),
            );
          }
          if (state is UserReviewLoaded) {
            return ListView.builder(
              itemCount: state.reviewsEntity.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ReviewsCard(review: state.reviewsEntity[index]),
                );
              }),
            );
          }

          if (state is UserReviewsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
