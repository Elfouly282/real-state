import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:real_state/core/api/internet_connection_checker.dart';
import 'package:real_state/core/errors/failure.dart';
import 'package:real_state/feature/favorite/data/data_source/favorites_remote_data_source.dart';
import 'package:real_state/feature/favorite/domain/entity/property_entity.dart';
import 'package:real_state/feature/favorite/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo; 

  FavoritesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo, 
  });

  @override
  Future<Either<Failure, List<PropertyEntity>>> getFavorites() async {
    // 3. يمكنك الآن استخدام networkInfo للتحقق من الاتصال
    if (!await networkInfo.isConnected) {
      return Left(ApiFailure(message: 'لا يوجد اتصال بالإنترنت'));
    }

    try {
      final result = await remoteDataSource.getFavorites();
      return Right(result);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? 'حدث خطأ في الاتصال بالسيرفر';
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite({required int propertyId}) async {
    if (!await networkInfo.isConnected) {
      return Left(ApiFailure(message: 'لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.toggleFavorite(propertyId: propertyId);
      return const Right(unit);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? 'حدث خطأ أثناء تحديث المفضلة';
      return Left(ApiFailure(message: message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}