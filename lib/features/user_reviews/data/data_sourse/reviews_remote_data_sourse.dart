import 'package:real_state/core/api/constant_API.dart';
import 'package:real_state/core/api/dio_helper.dart';
import 'package:real_state/features/user_reviews/data/models/reviews_model.dart';

class ReviewsRemoteDataSourse {
  Future<List<ReviewsModel>> getAllReviews(int property_id) async {
    final respoise = await DioHelper.getData(
      url: EndPoints.propertyReviews(property_id),
    );
    return (respoise.data['data'] as List)
        .map((e) => ReviewsModel.fromJson(e))
        .toList();
  }
}
