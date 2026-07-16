import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardEntity>> getDashboard();
}
