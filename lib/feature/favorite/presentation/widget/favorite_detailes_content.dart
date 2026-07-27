import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/feature/favorite/presentation/cubit/favorite_cubit.dart';

import 'package:real_state/feature/favorite/presentation/widget/favorite_property_item_card.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class FavoriteDetailesContent extends StatefulWidget {
  final String categoryTitle;

  const FavoriteDetailesContent({super.key, required this.categoryTitle});

  @override
  State<FavoriteDetailesContent> createState() =>
      _FavoriteDetailesContentState();
}

class _FavoriteDetailesContentState extends State<FavoriteDetailesContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
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
              SearchBarWidget(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
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
                    widget.categoryTitle,
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
                          child: Text('No items in favorites currently'),
                        ),
                      );
                    }

                    final category = widget.categoryTitle.toLowerCase();
                    final query = _searchQuery.trim().toLowerCase();

                    final categoryFavorites = state.favorites.where((property) {
                      if (category == 'house') {
                        return property.title.toLowerCase().contains('house') ||
                            property.title.toLowerCase().contains('villa') ||
                            property.address.toLowerCase().contains('house');
                      } else if (category == 'apartment') {
                        return property.title.toLowerCase().contains('apartment') ||
                            property.title.toLowerCase().contains('flat') ||
                            property.address.toLowerCase().contains('apartment');
                      }
                      return true;
                    }).toList();

                    final listToDisplay = categoryFavorites.isEmpty ? state.favorites : categoryFavorites;

                    final filteredFavorites = query.isEmpty
                        ? listToDisplay
                        : listToDisplay.where((property) {
                            final titleMatch =
                                property.title.toLowerCase().contains(query);
                            final addressMatch =
                                property.address.toLowerCase().contains(query);
                            return titleMatch || addressMatch;
                          }).toList();

                    if (filteredFavorites.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'No matching search results',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredFavorites.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final property = filteredFavorites[index];
                        return FavoritePropertyItemCard(
                          property: property,
                          onFavoriteToggle: () {
                            // Instant toggle favorite
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
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      context.read<FavoriteCubit>();
      return _buildBody(context);
    } catch (_) {
      return BlocProvider(
        create: (context) => getIt<FavoriteCubit>()..getFavorites(),
        child: Builder(
          builder: (context) => _buildBody(context),
        ),
      );
    }
  }
}
