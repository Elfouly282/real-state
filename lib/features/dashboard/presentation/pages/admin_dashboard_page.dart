import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/dashboard_cubit.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: getBoldStyle(
            fontSize: AppFonts.titleMedium,
            color: AppColors.secondaryColor,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is DashboardFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: getRegularStyle(
                      fontSize: AppFonts.bodyMedium,
                      color: AppColors.errorColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () => context.read<DashboardCubit>().load(),
                    icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
                    label: Text(
                      'إعادة المحاولة',
                      style: getMediumStyle(
                        fontSize: AppFonts.bodyMedium,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardSuccess) {
            final d = state.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth >= 800 ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: cols,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.6,
                    children: [
                      _KpiCard(
                        title: 'المستخدمون',
                        value: d.usersCount.toString(),
                        icon: Icons.people_outline,
                        color: AppColors.primaryColor,
                      ),
                      _KpiCard(
                        title: 'العقارات',
                        value: d.propertiesCount.toString(),
                        icon: Icons.home_work_outlined,
                        color: AppColors.infoColor,
                      ),
                      _KpiCard(
                        title: 'طلبات معلّقة',
                        value: d.ordersPending.toString(),
                        icon: Icons.pending_actions_outlined,
                        color: AppColors.warningColor,
                      ),
                      _KpiCard(
                        title: 'إيراد مدفوع',
                        value: '\$${d.paidRevenue.toStringAsFixed(0)}',
                        icon: Icons.attach_money_outlined,
                        color: AppColors.successColor,
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: getRegularStyle(
                    fontSize: AppFonts.labelSmall,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: getBoldStyle(
                    fontSize: AppFonts.headlineSmall,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
