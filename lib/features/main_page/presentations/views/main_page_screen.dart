import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/features/home/prsentations/views/home_screen.dart';
import 'package:real_state/features/main_page/data/models/bottom_nav_bar_item_model.dart';
import 'package:real_state/features/main_page/presentations/cubit/main_page_cubit.dart';
import 'package:real_state/features/main_page/presentations/cubit/main_page_state.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BottomNavBarItemModel> items = [
      BottomNavBarItemModel(
        screen: const HomeScreen(),
        icon: Icons.home_outlined,
        label: 'Home',
      ),
      BottomNavBarItemModel(
        screen: const HomeScreen(),
        icon: Icons.star_border_outlined,
        label: 'Favorite',
      ),
      BottomNavBarItemModel(
        screen: const HomeScreen(),
        icon: Icons.map_outlined,
        label: 'Map',
      ),
      BottomNavBarItemModel(
        screen: const HomeScreen(),
        icon: Icons.history_edu_outlined,
        label: 'History',
      ),
      BottomNavBarItemModel(
        screen: const HomeScreen(),
        icon: Icons.person_outline,
        label: 'Profile',
      ),
    ];

    return BlocProvider(
      create: (context) => getIt<MainPageCubit>(),
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          final cubit = context.read<MainPageCubit>();

          return Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: items.map((e) => e.screen).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Color(0xff1597A8),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              currentIndex: cubit.currentIndex,
              onTap: cubit.changeBottomNav,
              type: BottomNavigationBarType.fixed,
              items: items
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.label,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
