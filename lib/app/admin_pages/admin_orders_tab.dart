import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/admin_table_card.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../core/utils/date_helper.dart';
import '../../core/utils/status_badge_helper.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_loading_widget.dart';
import 'admin_pagination_bar.dart';
import 'admin_table_helpers.dart';

class AdminOrdersTab extends StatelessWidget {
  const AdminOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(builder: (ctx, state) {
      if (state is OrdersLoading) {
        return const AdminLoadingWidget();
      }
      if (state is OrdersFailure) {
        return AdminErrorView(
            message: state.message, onRetry: () => ctx.read<OrdersCubit>().load());
      }
      if (state is OrdersSuccess) {
        if (state.list.isEmpty) return const AdminEmptyView('No orders found');
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Total: ${state.meta.total} orders  •  Page ${state.meta.currentPage} of ${state.meta.lastPage}',
                  style: getRegularStyle(
                      fontSize: AppFonts.bodySmall,
                      color: AppColors.textSecondaryColor),
                ),
              ),
              Expanded(
                child: AdminTableCard(
                  minWidth: 1000,
                  columnFlexes: const [1, 2, 3, 2, 2, 2, 2],
                  headers: const [
                    'ID', 'User', 'Property', 'Amount', 'Currency', 'Status', 'Date'
                  ],
                  rows: state.list
                      .map((o) => DataRow(cells: [
                            DataCell(AdminTableW.cell('${o.id}')),
                            DataCell(AdminTableW.cell(o.user?.name ?? '-', bold: true)),
                            DataCell(AdminTableW.cell(o.property?.title ?? '-')),
                            DataCell(AdminTableW.cell('\$${o.amount.toStringAsFixed(0)}')),
                            DataCell(AdminTableW.badge(
                                o.currency.toUpperCase(), AppColors.primaryColor)),
                            DataCell(_orderBadge(o.status)),
                            DataCell(AdminTableW.cell(o.createdAt.toDateOnly())),
                          ]))
                      .toList(),
                ),
              ),
              AdminPaginationBar(
                currentPage: state.meta.currentPage,
                lastPage: state.meta.lastPage,
                onPrev: state.meta.currentPage > 1
                    ? () => ctx.read<OrdersCubit>().load(page: state.meta.currentPage - 1)
                    : null,
                onNext: state.meta.currentPage < state.meta.lastPage
                    ? () => ctx.read<OrdersCubit>().load(page: state.meta.currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      }
      return const AdminEmptyView('No orders');
    });
  }

  Widget _orderBadge(String status) =>
      AdminTableW.badge(status, orderStatusColor(status));
}
