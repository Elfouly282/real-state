import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/admin_table_card.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_styles.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import 'admin_empty_view.dart';
import 'admin_error_view.dart';
import 'admin_loading_widget.dart';
import 'admin_pagination_bar.dart';
import 'admin_table_helpers.dart';

class AdminCategoriesTab extends StatelessWidget {
  const AdminCategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(builder: (ctx, state) {
      if (state is CategoriesLoading || state is CategoriesActionLoading) {
        return const AdminLoadingWidget();
      }
      if (state is CategoriesFailure) {
        return AdminErrorView(
            message: state.message, onRetry: () => ctx.read<CategoriesCubit>().load());
      }
      if (state is CategoriesSuccess) {
        if (state.list.isEmpty) return const AdminEmptyView('No categories found');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
              child: Text(
                'Total: ${state.meta.total} categories  •  Page ${state.meta.currentPage} of ${state.meta.lastPage}',
                style: getRegularStyle(
                    fontSize: AppFonts.bodySmall,
                    color: AppColors.textSecondaryColor),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: AdminTableCard(
                  minWidth: 800,
                  columnFlexes: const [1, 3, 2, 4, 1, 2],
                  headers: const ['ID', 'Name', 'Slug', 'Description', 'Sort', 'Actions'],
                  rows: state.list
                  .map((c) => DataRow(cells: [
                        DataCell(AdminTableW.cell('${c.id}')),
                        DataCell(AdminTableW.cell(c.name, bold: true)),
                        DataCell(AdminTableW.cell(c.slug)),
                        DataCell(AdminTableW.cell(c.description ?? '-')),
                        DataCell(AdminTableW.cell('${c.sortOrder}')),
                        DataCell(Row(children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined,
                                size: 18, color: AppColors.infoColor),
                            tooltip: 'Edit',
                            onPressed: () => _showEdit(ctx, c.id, c.name),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                size: 18, color: AppColors.errorColor),
                            tooltip: 'Delete',
                            onPressed: () => _confirmDelete(ctx, c.id, c.name),
                          ),
                        ])),
                      ]))
                  .toList(),
                ),
              ),
            ),
            AdminPaginationBar(
              currentPage: state.meta.currentPage,
              lastPage: state.meta.lastPage,
              onPrev: state.meta.currentPage > 1
                  ? () => ctx.read<CategoriesCubit>().load(page: state.meta.currentPage - 1)
                  : null,
              onNext: state.meta.currentPage < state.meta.lastPage
                  ? () => ctx.read<CategoriesCubit>().load(page: state.meta.currentPage + 1)
                  : null,
            ),
            const SizedBox(height: 24),
          ],
        );
      }
      return const AdminEmptyView('No categories');
    });
  }

  void _showEdit(BuildContext ctx, int id, String current) {
    final ctrl = TextEditingController(text: current);
    bool disposed = false;

    void safeDispose() {
      if (!disposed) {
        disposed = true;
        ctrl.dispose();
      }
    }

    showDialog(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        title: Text('Edit Category',
            style: getBoldStyle(
                fontSize: AppFonts.titleSmall, color: AppColors.secondaryColor)),
        content: TextField(
            controller: ctrl, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dCtx);
              safeDispose();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = ctrl.text.trim();
              Navigator.pop(dCtx);
              safeDispose();
              ctx.read<CategoriesCubit>().update(id, name: name);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((_) => safeDispose());
  }

  void _confirmDelete(BuildContext ctx, int id, String name) {
    showDialog(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        title: Text('Delete "$name"?',
            style: getBoldStyle(
                fontSize: AppFonts.titleSmall, color: AppColors.secondaryColor)),
        content: Text('This action cannot be undone.',
            style: getRegularStyle(
                fontSize: AppFonts.bodyMedium, color: AppColors.textPrimaryColor)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dCtx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ctx.read<CategoriesCubit>().delete(id);
              Navigator.pop(dCtx);
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.errorColor)),
          ),
        ],
      ),
    );
  }
}
