import '../../domain/entities/dashboard_entity.dart';

/// Response structure:
/// ```json
/// [
///   {
///     "data": {
///       "users_count": 185,
///       "properties_count": 112,
///       "paid_revenue": 0,
///       "orders_pending": 179,
///       "orders_paid": 0
///     }
///   }
/// ]
/// ```
class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.usersCount,
    required super.propertiesCount,
    required super.paidRevenue,
    required super.ordersPending,
    required super.ordersPaid,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    // Handles both raw map or already-extracted data map
    final d = (json['data'] ?? json) as Map<String, dynamic>;
    return DashboardModel(
      usersCount: (d['users_count'] as num?)?.toInt() ?? 0,
      propertiesCount: (d['properties_count'] as num?)?.toInt() ?? 0,
      paidRevenue: (d['paid_revenue'] as num?)?.toDouble() ?? 0.0,
      ordersPending: (d['orders_pending'] as num?)?.toInt() ?? 0,
      ordersPaid: (d['orders_paid'] as num?)?.toInt() ?? 0,
    );
  }
}
