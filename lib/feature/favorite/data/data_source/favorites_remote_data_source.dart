import 'package:real_state/core/api/dio_helper.dart';

import '../models/favorite_property_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<FavoritePropertyModel>> getFavorites();
  Future<void> toggleFavorite({required int propertyId});
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  @override
  Future<List<FavoritePropertyModel>> getFavorites() async {
    final response = await DioHelper.getData(
      url: '/api/v1/favorites',
    );


    final List itemsJson = response.data['data'] ?? [];
    return itemsJson
        .map((item) => FavoritePropertyModel.fromJson(item))
        .toList();
  }

  @override
  Future<void> toggleFavorite({required int propertyId}) async {
    await DioHelper.postData(
      url: '/api/v1/favorites',
      data: {
        'property_id': propertyId,
      },
    );
  }
}