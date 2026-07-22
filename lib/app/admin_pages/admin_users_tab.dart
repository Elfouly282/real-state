import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/admin_table_card.dart';
import '../../core/constant/custom_toast.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/users/presentation/cubit/users_cubit.dart';
import '../../core/utils/date_helper.dart';
import 'admin_block_button.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_loading_widget.dart';
import 'admin_pagination_bar.dart';
import 'admin_table_helpers.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is UsersBlockFailure) {
          CustomToast.showError(state.message);
        }
      },
      child: BlocBuilder<UsersCubit, UsersState>(builder: (ctx, state) {
      if (state is UsersLoading || state is UsersActionLoading) {
        return const AdminLoadingWidget();
      }
      if (state is UsersFailure) {
        return AdminErrorView(
            message: state.message, onRetry: () => ctx.read<UsersCubit>().load());
      }
      if (state is UsersSuccess) {
        if (state.list.isEmpty) return const AdminEmptyView('No users found');
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Total: ${state.meta.total} users  •  Page ${state.meta.currentPage} of ${state.meta.lastPage}',
                  style: getRegularStyle(
                      fontSize: AppFonts.bodySmall,
                      color: AppColors.textSecondaryColor),
                ),
              ),
              Expanded(
                child: AdminTableCard(
                  minWidth: 950,
                  columnFlexes: const [1, 3, 3, 2, 2, 2, 2, 2],
                  headers: const ['ID', 'Name', 'Email', 'Phone', 'Location', 'Role', 'Joined', 'Actions'],
                  rows: state.list
                      .map((u) => DataRow(cells: [
                            DataCell(AdminTableW.cell('${u.id}')),
                            DataCell(Row(children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.primaryColor,
                                child: Text(
                                  u.name.isNotEmpty ? u.name[0].toUpperCase() : '?',
                                  style: getMediumStyle(
                                      fontSize: AppFonts.labelSmall,
                                      color: AppColors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(u.name,
                                    style: getMediumStyle(
                                        fontSize: AppFonts.bodyMedium,
                                        color: AppColors.secondaryColor),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ])),
                            DataCell(AdminTableW.cell(u.email)),
                            DataCell(AdminTableW.cell(u.phone ?? '-')),
                            DataCell(AdminTableW.cell(u.location ?? '-')),
                            DataCell(AdminTableW.badge(u.role,
                                u.role == 'admin' ? AppColors.errorColor : AppColors.primaryColor)),
                            DataCell(AdminTableW.cell(u.createdAt.toDateOnly())),
                            DataCell(
                              AdminBlockButton(
                                isBlocked: u.isBlocked,
                                onTap: () => ctx.read<UsersCubit>().block(u.id),
                              ),
                            ),
                          ]))
                      .toList(),
                ),
              ),
              AdminPaginationBar(
                currentPage: state.meta.currentPage,
                lastPage: state.meta.lastPage,
                onPrev: state.meta.currentPage > 1
                    ? () => ctx.read<UsersCubit>().load(page: state.meta.currentPage - 1)
                    : null,
                onNext: state.meta.currentPage < state.meta.lastPage
                    ? () => ctx.read<UsersCubit>().load(page: state.meta.currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      }
      return const AdminEmptyView('No users');
    }),
    );
  }
}
