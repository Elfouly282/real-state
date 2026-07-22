import 'package:dartz/dartz.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/features/home/domain/entity/home_entity.dart';
import 'package:real_state/features/home/domain/repository/home_repository.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeEntity>> call({int? categoryID, String? search}) {
    return repository.getHomeData(categoryID: categoryID, search: search);
  }
}
