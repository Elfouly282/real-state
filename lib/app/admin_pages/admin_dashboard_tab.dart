import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/app_constants.dart';
import '../../core/utils/app_colors.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_loading_widget.dart';
import 'admin_stats_card.dart';

class AdminDashboardTab extends StatelessWidget {
  const AdminDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(builder: (ctx, state) {
      if (state is DashboardLoading) {
        return const AdminLoadingWidget();
      }
      if (state is DashboardFailure) {
        return AdminErrorView(
            message: state.message, onRetry: () => ctx.read<DashboardCubit>().load());
      }
      if (state is DashboardSuccess) {
        final d = state.data;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(builder: (_, c) {
            final cols = c.maxWidth >= AppConstants.kBreakpointWide ? 4 : c.maxWidth >= AppConstants.kBreakpointMedium ? 2 : 1;
            final ratio = c.maxWidth >= AppConstants.kBreakpointWide ? 2.2 : 1.8;
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
                    color: AppColors.primaryColor),
                AdminStatsCard(
                    title: 'Properties',
                    value: '${d.propertiesCount}',
                    icon: Icons.home_work_outlined,
                    color: AppColors.infoColor),
                AdminStatsCard(
                    title: 'Pending Orders',
                    value: '${d.ordersPending}',
                    icon: Icons.pending_actions_outlined,
                    color: AppColors.warningColor),
                AdminStatsCard(
                    title: 'Paid Revenue',
                    value: '\$${d.paidRevenue.toStringAsFixed(0)}',
                    icon: Icons.attach_money_outlined,
                    color: AppColors.successColor),
              ],
            );
          }),
        );
      }
      return const AdminEmptyView('No data');
    });
  }
}
