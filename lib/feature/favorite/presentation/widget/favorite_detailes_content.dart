import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/feature/favorite/presentation/cubit/favorite_cubit.dart';

import 'package:real_state/feature/favorite/presentation/widget/favorite_property_item_card.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class FavoriteDetailesContent extends StatelessWidget {
  final String categoryTitle;

  const FavoriteDetailesContent({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<FavoriteCubit>()..getFavorites(),
      child:   Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const LocationHeaderWidget(),
                const SizedBox(height: 16),
                const SearchBarWidget(),
                const SizedBox(height: 20),

                // شريط العودة
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // بناء القائمة التفاعلية بواسطة الـ Cubit
                BlocConsumer<FavoriteCubit, FavoriteState>(
                  listener: (context, state) {
                    if (state is FavoritesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is FavoritesLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FavoritesLoaded) {
                      if (state.favorites.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('لا توجد عناصر في المفضلة حالياً'),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.favorites.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final property = state.favorites[index];
                          return FavoritePropertyItemCard(
                            property: property,
                            onFavoriteToggle: () {
                              // التبديل اللحظي (حذف فور يختفي من الـ UI)
                              context.read<FavoriteCubit>().toggleFavorite(
                                property,
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
