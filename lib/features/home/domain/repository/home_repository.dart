import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/features/home/domain/entity/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHomeData({
    int? categoryID,
    String? search,
  });
}
