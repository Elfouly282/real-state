import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constant/custom_logo.dart';
import '../core/di.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_fonts.dart';
import '../core/utils/app_styles.dart';
import '../features/agents/agents_di.dart';
import '../features/agents/presentation/cubit/agents_cubit.dart';
import '../features/categories/categories_di.dart';
import '../features/categories/presentation/cubit/categories_cubit.dart';
import '../features/dashboard/dashboard_di.dart';
import '../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../features/orders/orders_di.dart';
import '../features/orders/presentation/cubit/orders_cubit.dart';
import '../features/properties/presentation/cubit/properties_cubit.dart';
import '../features/properties/properties_di.dart';
import '../features/users/presentation/cubit/users_cubit.dart';
import '../features/users/users_di.dart';
import 'admin_pages.dart';

// ─── Nav item model ──────────────────────────────────────────────────────────

class _NavItem {
  final String label;
  final IconData icon;
  final Widget Function() pageBuilder;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.pageBuilder,
  });
}

// ─── Shell ───────────────────────────────────────────────────────────────────

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _selectedIndex = 0;

  late final List<_NavItem> _items = [
    _NavItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<DashboardCubit>()..load(),
        child: const AdminDashboardTab(),
      ),
    ),
    _NavItem(
      label: 'Categories',
      icon: Icons.category_outlined,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<CategoriesCubit>()..load(),
        child: const AdminCategoriesTab(),
      ),
    ),
    _NavItem(
      label: 'Properties',
      icon: Icons.home_work_outlined,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<PropertiesCubit>()..load(),
        child: const AdminPropertiesTab(),
      ),
    ),
    _NavItem(
      label: 'Agents',
      icon: Icons.support_agent_outlined,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<AgentsCubit>()..load(),
        child: const AdminAgentsTab(),
      ),
    ),
    _NavItem(
      label: 'Users',
      icon: Icons.people_outline,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<UsersCubit>()..load(),
        child: const AdminUsersTab(),
      ),
    ),
    _NavItem(
      label: 'Orders',
      icon: Icons.receipt_long_outlined,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<OrdersCubit>()..load(),
        child: const AdminOrdersTab(),
      ),
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 800;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F6FA),
      drawer: isWide ? null : _Sidebar(
        items: _items,
        selectedIndex: _selectedIndex,
        onSelect: (i) {
          setState(() => _selectedIndex = i);
          Navigator.pop(context);
        },
      ),
      body: Row(
        children: [
          if (isWide) _Sidebar(
            items: _items,
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopBar(
                  title: _items[_selectedIndex].label,
                  showMenu: !isWide,
                  onMenu: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Expanded(
                  child: KeyedSubtree(
                    key: ValueKey(_selectedIndex),
                    child: _items[_selectedIndex].pageBuilder(),
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

// ─── Sidebar ─────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _Sidebar({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Row(
              children: [
                CustomLogo(width: 32, height: 32),
                const SizedBox(width: 10),
                Text(
                  'Real State',
                  style: getBoldStyle(
                    fontSize: AppFonts.titleSmall,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),
          // Nav items
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) => _SidebarTile(
                item: items[i],
                isSelected: i == selectedIndex,
                onTap: () => onSelect(i),
              ),
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          // Logout
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: AppColors.grey, size: 20),
            title: Text('Logout', style: getRegularStyle(fontSize: AppFonts.bodyMedium, color: AppColors.grey)),
            onTap: () {},
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarTile({required this.item, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? const Border(left: BorderSide(color: AppColors.primaryColor, width: 3))
              : null,
        ),
        child: Row(
          children: [
            Icon(item.icon, size: 20, color: isSelected ? AppColors.primaryColor : AppColors.grey),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: isSelected
                  ? getMediumStyle(fontSize: AppFonts.bodyMedium, color: AppColors.white)
                  : getRegularStyle(fontSize: AppFonts.bodyMedium, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final String title;
  final bool showMenu;
  final VoidCallback onMenu;

  const _TopBar({required this.title, required this.showMenu, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.greychip)),
        boxShadow: [BoxShadow(color: AppColors.shadowColor, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          if (showMenu) ...[
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.secondaryColor),
              onPressed: onMenu,
            ),
            const SizedBox(width: 4),
          ],
          Text(title, style: getBoldStyle(fontSize: AppFonts.titleMedium, color: AppColors.secondaryColor)),
          const Spacer(),
          // Notification
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: AppColors.secondaryColor),
                onPressed: () {},
              ),
              Positioned(
                right: 8, top: 8,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: AppColors.errorColor, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryColor,
            child: Text('A', style: getBoldStyle(fontSize: AppFonts.bodyMedium, color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
