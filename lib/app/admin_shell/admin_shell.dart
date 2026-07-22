import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/custom_toast.dart';
import '../../core/utils/app_colors.dart';
import '../../core/di.dart';
import '../../core/utils/app_icons.dart';
import '../../features/agents/presentation/cubit/agents_cubit.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../features/properties/presentation/cubit/properties_cubit.dart';
import '../../features/users/presentation/cubit/users_cubit.dart';
import '../../core/constant/app_constants.dart';
import '../../features/auth/domain/entities/auth_entity.dart';
import '../admin_pages.dart';
import 'admin_nav_item.dart';
import 'admin_sidebar.dart';
import 'admin_top_bar.dart';

class AdminShell extends StatefulWidget {
  final AuthEntity? admin;
  const AdminShell({super.key, this.admin});

  @override
  State<AdminShell> createState() => AdminShellState();
}

class AdminShellState extends State<AdminShell> {
  int _selectedIndex = 0;

  final Map<int, Widget> _pageCache = {};

  late final List<AdminNavItem> _items = [
    AdminNavItem(
      label: 'Dashboard',
      icon: AppIcons.dashboard,
      svgIcon: AppIcons.dashboardSvg,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<DashboardCubit>()..load(),
        child: const AdminDashboardTab(),
      ),
    ),
    AdminNavItem(
      label: 'Categories',
      icon: AppIcons.categories,
      svgIcon: AppIcons.categorySvg,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<CategoriesCubit>()..load(),
        child: const AdminCategoriesTab(),
      ),
    ),
    AdminNavItem(
      label: 'Properties',
      icon: AppIcons.properties,
      svgIcon: AppIcons.homeSvg,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<PropertiesCubit>()..load(),
        child: const AdminPropertiesTab(),
      ),
    ),
    AdminNavItem(
      label: 'Agents',
      icon: AppIcons.agents,
      svgIcon: AppIcons.agentSvg,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<AgentsCubit>()..load(),
        child: const AdminAgentsTab(),
      ),
    ),
    AdminNavItem(
      label: 'Users',
      icon: AppIcons.users,
      svgIcon: AppIcons.usersSvg,
      pageBuilder: () => BlocProvider(
        create: (_) => getIt<UsersCubit>()..load(),
        child: const AdminUsersTab(),
      ),
    ),
    AdminNavItem(
      label: 'Orders',
      icon: AppIcons.orders,
      svgIcon: AppIcons.orderSvg,
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
    final isWide = w >= AppConstants.kBreakpointSidebar;

    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => getIt<AuthCubit>(),
                  child: const LoginPage(),
                ),
              ),
              (route) => false,
            );
          }
          if (state is AuthFailure) {
            CustomToast.showError(state.message);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.scaffoldBg,
          drawer: isWide
              ? null
              : AdminSidebar(
                  items: _items,
                  selectedIndex: _selectedIndex,
                  onSelect: (i) {
                    setState(() => _selectedIndex = i);
                    Navigator.pop(context);
                  },
                ),
          body: Row(
            children: [
              if (isWide)
                AdminSidebar(
                  items: _items,
                  selectedIndex: _selectedIndex,
                  onSelect: (i) => setState(() => _selectedIndex = i),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AdminTopBar(
                      title: _items[_selectedIndex].label,
                      svgIcon: _items[_selectedIndex].svgIcon,
                      showMenu: !isWide,
                      onMenu: () => _scaffoldKey.currentState?.openDrawer(),
                      admin: widget.admin,
                    ),
                    Expanded(
                      child: _pageCache.putIfAbsent(
                        _selectedIndex,
                        () => _items[_selectedIndex].pageBuilder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
