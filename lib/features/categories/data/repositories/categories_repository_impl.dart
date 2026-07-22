import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_datasource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDatasource _remote;
  final NetworkInfo _network;

  CategoriesRepositoryImpl({
    required CategoriesRemoteDatasource remote,
    required NetworkInfo network,
  })  : _remote = remote,
        _network = network;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() fn) async {
    if (!await _network.isConnected) {
      return Left(NoInternetFailure(message: 'No Internet Connection'));
    }
    try {
      return Right(await fn());
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ServiceFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedCategoriesEntity>> getCategories({int perPage = 50, int page = 1}) =>
      _run(() => _remote.getCategories(perPage: perPage, page: page));

  @override
  Future<Either<Failure, CategoryEntity>> getCategory(int id) =>
      _run(() => _remote.getCategory(id));

  @override
  Future<Either<Failure, CategoryEntity>> createCategory({
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) =>
      _run(() => _remote.createCategory(
            name: name,
            slug: slug,
            description: description,
            sortOrder: sortOrder,
          ));

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(
    int id, {
    required String name,
    String? slug,
    String? description,
    int? sortOrder,
  }) =>
      _run(() => _remote.updateCategory(
            id,
            name: name,
            slug: slug,
            description: description,
            sortOrder: sortOrder,
          ));

  @override
  Future<Either<Failure, bool>> deleteCategory(int id) =>
      _run(() => _remote.deleteCategory(id));
}
