import '../../domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.usersCount,
    required super.propertiesCount,
    required super.paidRevenue,
    required super.ordersPending,
    required super.ordersPaid,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
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
