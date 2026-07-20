import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_state/core/utils/app_styles.dart';
import 'package:real_state/features/user_reviews/domain/entites/reviews_entity.dart';

class ReviewsCard extends StatelessWidget {
  final ReviewsEntity? review;
  const ReviewsCard({super.key, this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage: review != null
                    ? NetworkImage(review!.user.image)
                    : null,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Text(
                review?.user.name ?? 'loading user',
                style: getLightStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.008),
          Row(
            children: [
              Row(
                children: List.generate(
                  review?.rating ?? 5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.005),
              Text('${review?.rating ?? 5}/5'),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.008),
          Text(
            review?.comment ?? 'loading comment',
            style: getMediumStyle(fontSize: 23, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
