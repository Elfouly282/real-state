import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/admin_pages/admin_empty_view.dart';
import '../../../../app/admin_pages/admin_error_view.dart';
import '../../../../app/admin_pages/admin_loading_widget.dart';
import '../../../../app/admin_pages/admin_stats_card.dart';
import '../../../../core/constant/app_constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/dashboard_cubit.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
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
          if (state is DashboardLoading) return const AdminLoadingWidget();

          if (state is DashboardFailure) {
            return AdminErrorView(
              message: state.message,
              onRetry: () => context.read<DashboardCubit>().load(),
            );
          }

          if (state is DashboardSuccess) {
            final d = state.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth >= AppConstants.kBreakpointWide
                      ? 4
                      : constraints.maxWidth >= AppConstants.kBreakpointMedium
                          ? 2
                          : 1;
                  final ratio =
                      constraints.maxWidth >= AppConstants.kBreakpointWide ? 2.2 : 1.8;
                  return GridView.count(
                    crossAxisCount: cols,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: ratio,
                    children: [
                      AdminStatsCard(
                        title: 'Users',
                        value: '${d.usersCount}',
                        icon: Icons.people_outline,
                        color: AppColors.primaryColor,
                      ),
                      AdminStatsCard(
                        title: 'Properties',
                        value: '${d.propertiesCount}',
                        icon: Icons.home_work_outlined,
                        color: AppColors.infoColor,
                      ),
                      AdminStatsCard(
                        title: 'Pending Orders',
                        value: '${d.ordersPending}',
                        icon: Icons.pending_actions_outlined,
                        color: AppColors.warningColor,
                      ),
                      AdminStatsCard(
                        title: 'Paid Revenue',
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

          return const AdminEmptyView('No data');
        },
      ),
    );
  }
}
