import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardUsecase {
  final DashboardRepository _repo;
  GetDashboardUsecase(this._repo);
  Future<Either<Failure, DashboardEntity>> call() => _repo.getDashboard();
}
