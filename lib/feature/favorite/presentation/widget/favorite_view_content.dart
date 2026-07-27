import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_detailes_content.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_folder_card_widget.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class FavoriteViewContent extends StatelessWidget {
  const FavoriteViewContent({super.key});

  void _navigateToDetails(BuildContext context, {String title = 'Favorites'}) {
    final cubit = context.read<FavoriteCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: cubit,
          child: FavoriteDetailesContent(categoryTitle: title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                ontap: () => _navigateToDetails(context, title: 'Favorites'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Favorite',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
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
                          child: Text(
                            'No items in favorites currently',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    // Group images from favorite items for folder view
                    final allImages = state.favorites
                        .expand((p) => p.imageUrls)
                        .where((img) => img.isNotEmpty)
                        .toList();

                    final houseProperties = state.favorites.where((p) =>
                        p.title.toLowerCase().contains('house') ||
                        p.title.toLowerCase().contains('villa') ||
                        p.address.toLowerCase().contains('house')).toList();
                    final apartmentProperties = state.favorites.where((p) =>
                        p.title.toLowerCase().contains('apartment') ||
                        p.title.toLowerCase().contains('flat') ||
                        p.address.toLowerCase().contains('apartment')).toList();

                    final houseImages = houseProperties.expand((p) => p.imageUrls).toList();
                    final apartmentImages = apartmentProperties.expand((p) => p.imageUrls).toList();

                    return Row(
                      children: [
                        Expanded(
                          child: FavoriteFolderCardWidget(
                            title: 'House',
                            subtitle: '${houseProperties.isNotEmpty ? houseProperties.length : state.favorites.length} Items',
                            images: houseImages.take(4).toList().isEmpty
                                ? (allImages.take(4).toList().isEmpty
                                    ? const [
                                        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c'
                                      ]
                                    : allImages.take(4).toList())
                                : houseImages.take(4).toList(),
                            onTap: () => _navigateToDetails(
                              context,
                              title: 'House',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FavoriteFolderCardWidget(
                            title: 'Apartment',
                            subtitle: '${apartmentProperties.isNotEmpty ? apartmentProperties.length : state.favorites.length} Items',
                            images: apartmentImages.take(4).toList().isEmpty
                                ? (allImages.skip(4).take(4).toList().isEmpty
                                    ? (allImages.take(4).toList().isEmpty
                                        ? const [
                                            'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00'
                                          ]
                                        : allImages.take(4).toList())
                                    : allImages.skip(4).take(4).toList())
                                : apartmentImages.take(4).toList(),
                            onTap: () => _navigateToDetails(
                              context,
                              title: 'Apartment',
                            ),
                          ),
                        ),
                      ],
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
}
