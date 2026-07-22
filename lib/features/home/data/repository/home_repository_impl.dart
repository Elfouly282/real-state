import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/features/home/data/data_source/home_remote_data_source.dart';
import 'package:real_state/features/home/domain/entity/home_entity.dart';
import 'package:real_state/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);
  @override
  Future<Either<Failure, HomeEntity>> getHomeData({
    int? categoryID,
    String? search,
  }) async {
    try {
      final res = await _homeRemoteDataSource.getHomeData(
        categoryID: categoryID,
        search: search,
      );
      return Right(res.toEntity());
    } catch (e) {
      if (e is ServerException) {
        return left(ServiceFailure(message: e.message));
      }
      return left(ServiceFailure(message: e.toString()));
    }
  }
}
