import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_fonts.dart';
import '../core/utils/app_styles.dart';
import '../features/agents/presentation/cubit/agents_cubit.dart';
import '../features/categories/presentation/cubit/categories_cubit.dart';
import '../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../features/orders/presentation/cubit/orders_cubit.dart';
import '../features/properties/presentation/cubit/properties_cubit.dart';
import '../features/users/presentation/cubit/users_cubit.dart';

// ─── Shared private widgets ───────────────────────────────────────────────────

class _Loading extends StatelessWidget {
  const _Loading();
  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(message,
              style: getRegularStyle(fontSize: AppFonts.bodyMedium, color: AppColors.errorColor),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            label: Text('Retry',
                style: getMediumStyle(fontSize: AppFonts.bodyMedium, color: AppColors.primaryColor)),
          ),
        ]),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  final String message;
  const _Empty(this.message);
  @override
  Widget build(BuildContext context) => Center(
        child: Text(message,
            style: getRegularStyle(
                fontSize: AppFonts.bodyMedium, color: AppColors.textSecondaryColor)),
      );
}

// ─── Stats Card ───────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatsCard(
      {required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: getRegularStyle(
                      fontSize: AppFonts.labelSmall, color: AppColors.textSecondaryColor)),
              const SizedBox(height: 4),
              Text(value,
                  style: getBoldStyle(
                      fontSize: AppFonts.headlineSmall, color: AppColors.secondaryColor)),
            ],
          ),
        ),
      ]),
    );
  }
}

// ─── Table Card ───────────────────────────────────────────────────────────────

class _TableCard extends StatelessWidget {
  final List<String> headers;
  final List<DataRow> rows;

  const _TableCard({required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width >= 800 ? 268 : 48)),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.lightGrayColor),
              columnSpacing: 20,
              horizontalMargin: 16,
              columns: headers
                  .map((h) => DataColumn(
                        label: Text(h,
                            style: getMediumStyle(
                                fontSize: AppFonts.labelSmall,
                                color: AppColors.textSecondaryColor)),
                      ))
                  .toList(),
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Cell / Badge helpers (as static methods inside a utility class) ──────────

class _W {
  static Widget cell(String text, {bool bold = false}) => Text(
        text,
        style: bold
            ? getMediumStyle(fontSize: AppFonts.bodyMedium, color: AppColors.secondaryColor)
            : getRegularStyle(fontSize: AppFonts.bodySmall, color: AppColors.textSecondaryColor),
        overflow: TextOverflow.ellipsis,
      );

  static Widget badge(String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
        child:
            Text(label, style: getMediumStyle(fontSize: AppFonts.labelSmall, color: color)),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. DASHBOARD TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminDashboardTab extends StatelessWidget {
  const AdminDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(builder: (ctx, state) {
      if (state is DashboardLoading) return const _Loading();
      if (state is DashboardFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<DashboardCubit>().load());
      if (state is DashboardSuccess) {
        final d = state.data;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(builder: (_, c) {
            final cols = c.maxWidth >= 900 ? 4 : c.maxWidth >= 500 ? 2 : 1;
            final ratio = c.maxWidth >= 900 ? 2.2 : 1.8;
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: ratio,
              children: [
                _StatsCard(
                    title: 'Users',
                    value: '${d.usersCount}',
                    icon: Icons.people_outline,
                    color: AppColors.primaryColor),
                _StatsCard(
                    title: 'Properties',
                    value: '${d.propertiesCount}',
                    icon: Icons.home_work_outlined,
                    color: AppColors.infoColor),
                _StatsCard(
                    title: 'Pending Orders',
                    value: '${d.ordersPending}',
                    icon: Icons.pending_actions_outlined,
                    color: AppColors.warningColor),
                _StatsCard(
                    title: 'Paid Revenue',
                    value: '\$${d.paidRevenue.toStringAsFixed(0)}',
                    icon: Icons.attach_money_outlined,
                    color: AppColors.successColor),
              ],
            );
          }),
        );
      }
      return const _Empty('No data');
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. CATEGORIES TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminCategoriesTab extends StatelessWidget {
  const AdminCategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(builder: (ctx, state) {
      if (state is CategoriesLoading || state is CategoriesActionLoading)
        return const _Loading();
      if (state is CategoriesFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<CategoriesCubit>().load());
      if (state is CategoriesSuccess) {
        if (state.list.isEmpty) return const _Empty('No categories found');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _TableCard(
            headers: const ['ID', 'Name', 'Slug', 'Description', 'Sort', 'Actions'],
            rows: state.list
                .map((c) => DataRow(cells: [
                      DataCell(_W.cell('${c.id}')),
                      DataCell(_W.cell(c.name, bold: true)),
                      DataCell(_W.cell(c.slug)),
                      DataCell(_W.cell(c.description ?? '-')),
                      DataCell(_W.cell('${c.sortOrder}')),
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
        );
      }
      return const _Empty('No categories');
    });
  }

  void _showEdit(BuildContext ctx, int id, String current) {
    final ctrl = TextEditingController(text: current);
    showDialog(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        title: Text('Edit Category',
            style: getBoldStyle(
                fontSize: AppFonts.titleSmall, color: AppColors.secondaryColor)),
        content: TextField(
            controller: ctrl, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dCtx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ctx.read<CategoriesCubit>().update(id, name: ctrl.text.trim());
              Navigator.pop(dCtx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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

// ─────────────────────────────────────────────────────────────────────────────
// 3. PROPERTIES TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminPropertiesTab extends StatelessWidget {
  const AdminPropertiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertiesCubit, PropertiesState>(builder: (ctx, state) {
      if (state is PropertiesLoading || state is PropertiesActionLoading)
        return const _Loading();
      if (state is PropertiesFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<PropertiesCubit>().load());
      if (state is PropertiesSuccess) {
        if (state.list.isEmpty) return const _Empty('No properties found');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _TableCard(
            headers: const ['ID', 'Title', 'Type', 'Price', 'Status', 'City', 'Actions'],
            rows: state.list
                .map((p) => DataRow(cells: [
                      DataCell(_W.cell('${p.id}')),
                      DataCell(_W.cell(p.title, bold: true)),
                      DataCell(_W.cell(p.type ?? '-')),
                      DataCell(_W.cell('\$${p.price.toStringAsFixed(0)}')),
                      DataCell(_propBadge(p.status)),
                      DataCell(_W.cell(p.city ?? '-')),
                      DataCell(IconButton(
                        icon: const Icon(Icons.delete_outline,
                            size: 18, color: AppColors.errorColor),
                        onPressed: () => ctx.read<PropertiesCubit>().delete(p.id),
                      )),
                    ]))
                .toList(),
          ),
        );
      }
      return const _Empty('No properties');
    });
  }

  Widget _propBadge(String status) {
    final Color c;
    switch (status.toLowerCase()) {
      case 'available':
        c = AppColors.successColor;
        break;
      case 'sold':
        c = AppColors.errorColor;
        break;
      case 'pending':
        c = AppColors.warningColor;
        break;
      default:
        c = AppColors.textSecondaryColor;
    }
    return _W.badge(status, c);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. AGENTS TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminAgentsTab extends StatelessWidget {
  const AdminAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentsCubit, AgentsState>(builder: (ctx, state) {
      if (state is AgentsLoading || state is AgentsActionLoading) return const _Loading();
      if (state is AgentsFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<AgentsCubit>().load());
      if (state is AgentsSuccess) {
        if (state.list.isEmpty) return const _Empty('No agents found');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _TableCard(
            headers: const ['ID', 'Name', 'Email', 'Phone', 'Properties', 'Actions'],
            rows: state.list
                .map((a) => DataRow(cells: [
                      DataCell(_W.cell('${a.id}')),
                      DataCell(_W.cell(a.name, bold: true)),
                      DataCell(_W.cell(a.email)),
                      DataCell(_W.cell(a.phone ?? '-')),
                      DataCell(_W.badge('${a.propertiesCount}', AppColors.infoColor)),
                      DataCell(IconButton(
                        icon: const Icon(Icons.delete_outline,
                            size: 18, color: AppColors.errorColor),
                        onPressed: () => ctx.read<AgentsCubit>().delete(a.id),
                      )),
                    ]))
                .toList(),
          ),
        );
      }
      return const _Empty('No agents');
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. USERS TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(builder: (ctx, state) {
      if (state is UsersLoading || state is UsersActionLoading) return const _Loading();
      if (state is UsersFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<UsersCubit>().load());
      if (state is UsersSuccess) {
        if (state.list.isEmpty) return const _Empty('No users found');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _TableCard(
            headers: const ['ID', 'Name', 'Email', 'Phone', 'Role', 'Status', 'Actions'],
            rows: state.list
                .map((u) => DataRow(cells: [
                      DataCell(_W.cell('${u.id}')),
                      DataCell(Row(children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            u.name.isNotEmpty ? u.name[0].toUpperCase() : '?',
                            style: getMediumStyle(
                                fontSize: AppFonts.labelSmall, color: AppColors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(u.name,
                              style: getMediumStyle(
                                  fontSize: AppFonts.bodyMedium,
                                  color: AppColors.secondaryColor),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ])),
                      DataCell(_W.cell(u.email)),
                      DataCell(_W.cell(u.phone ?? '-')),
                      DataCell(_W.badge(u.role, AppColors.infoColor)),
                      DataCell(_W.badge(
                          u.isBlocked ? 'Blocked' : 'Active',
                          u.isBlocked ? AppColors.errorColor : AppColors.successColor)),
                      DataCell(IconButton(
                        icon: Icon(
                          u.isBlocked
                              ? Icons.lock_open_outlined
                              : Icons.block_outlined,
                          size: 18,
                          color: u.isBlocked
                              ? AppColors.successColor
                              : AppColors.errorColor,
                        ),
                        tooltip: u.isBlocked ? 'Unblock' : 'Block',
                        onPressed: () => ctx.read<UsersCubit>().block(u.id),
                      )),
                    ]))
                .toList(),
          ),
        );
      }
      return const _Empty('No users');
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. ORDERS TAB
// ─────────────────────────────────────────────────────────────────────────────

class AdminOrdersTab extends StatelessWidget {
  const AdminOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(builder: (ctx, state) {
      if (state is OrdersLoading) return const _Loading();
      if (state is OrdersFailure)
        return _ErrorView(
            message: state.message, onRetry: () => ctx.read<OrdersCubit>().load());
      if (state is OrdersSuccess) {
        if (state.list.isEmpty) return const _Empty('No orders found');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _TableCard(
            headers: const ['ID', 'User', 'Property', 'Price', 'Status', 'Date'],
            rows: state.list
                .map((o) => DataRow(cells: [
                      DataCell(_W.cell('${o.id}')),
                      DataCell(_W.cell(o.userName, bold: true)),
                      DataCell(_W.cell(o.propertyTitle)),
                      DataCell(_W.cell('\$${o.totalPrice.toStringAsFixed(0)}')),
                      DataCell(_orderBadge(o.status)),
                      DataCell(_W.cell(o.createdAt)),
                    ]))
                .toList(),
          ),
        );
      }
      return const _Empty('No orders');
    });
  }

  Widget _orderBadge(String status) {
    final Color c;
    switch (status.toLowerCase()) {
      case 'paid':
        c = AppColors.successColor;
        break;
      case 'pending':
        c = AppColors.warningColor;
        break;
      case 'cancelled':
        c = AppColors.errorColor;
        break;
      default:
        c = AppColors.textSecondaryColor;
    }
    return _W.badge(status, c);
  }
}
