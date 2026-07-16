class DashboardEntity {
  final int usersCount;
  final int propertiesCount;
  final double paidRevenue;
  final int ordersPending;
  final int ordersPaid;

  const DashboardEntity({
    required this.usersCount,
    required this.propertiesCount,
    required this.paidRevenue,
    required this.ordersPending,
    required this.ordersPaid,
  });
}
