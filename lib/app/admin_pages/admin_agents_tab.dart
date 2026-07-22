import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/admin_table_card.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/agents/presentation/cubit/agents_cubit.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_loading_widget.dart';
import 'admin_pagination_bar.dart';
import 'admin_table_helpers.dart';

class AdminAgentsTab extends StatelessWidget {
  const AdminAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentsCubit, AgentsState>(builder: (ctx, state) {
      if (state is AgentsLoading || state is AgentsActionLoading) {
        return const AdminLoadingWidget();
      }
      if (state is AgentsFailure) {
        return AdminErrorView(
            message: state.message,
            onRetry: () => ctx.read<AgentsCubit>().load());
      }
      if (state is AgentsSuccess) {
        if (state.list.isEmpty) return const AdminEmptyView('No agents found');
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Total: ${state.meta.total} agents  •  Page ${state.meta.currentPage} of ${state.meta.lastPage}',
                  style: getRegularStyle(
                      fontSize: AppFonts.bodySmall,
                      color: AppColors.textSecondaryColor),
                ),
              ),
              Expanded(
                child: AdminTableCard(
                  minWidth: 860,
                  columnFlexes: const [1, 3, 2, 2, 3, 2, 1],
                  headers: const [
                    'ID',
                    'Title',
                    'Company',
                    'Agent Name',
                    'Email',
                    'Role',
                    'Actions'
                  ],
                  rows: state.list
                      .map((a) => DataRow(cells: [
                            DataCell(AdminTableW.cell('${a.id}')),
                            DataCell(AdminTableW.cell(a.title, bold: true)),
                            DataCell(AdminTableW.cell(a.company ?? '-')),
                            DataCell(AdminTableW.cell(a.user?.name ?? '-')),
                            DataCell(AdminTableW.cell(a.user?.email ?? '-')),
                            DataCell(AdminTableW.badge(
                                a.user?.role ?? '-',
                                AppColors.primaryColor)),
                            DataCell(IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: AppColors.errorColor),
                              tooltip: 'Delete',
                              onPressed: () => ctx.read<AgentsCubit>().delete(a.id),
                            )),
                          ]))
                      .toList(),
                ),
              ),
              AdminPaginationBar(
                currentPage: state.meta.currentPage,
                lastPage: state.meta.lastPage,
                onPrev: state.meta.currentPage > 1
                    ? () => ctx.read<AgentsCubit>().load(page: state.meta.currentPage - 1)
                    : null,
                onNext: state.meta.currentPage < state.meta.lastPage
                    ? () => ctx.read<AgentsCubit>().load(page: state.meta.currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      }
      return const AdminEmptyView('No agents');
    });
  }
}
