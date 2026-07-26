import 'package:flutter/material.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_detailes_content.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_folder_card_widget.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class FavoriteViewContent extends StatelessWidget {
  const FavoriteViewContent({super.key});

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
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FavoriteDetailesContent(
                            categoryTitle: 'Apartment',
                          ), 
                    ),
                  );
                },
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

              Row(
                children: [
                  Expanded(
                    child: FavoriteFolderCardWidget(
                      title: 'House',
                      subtitle: 'Today',
                      images: const [
                        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
                        'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7',
                        'https://images.unsplash.com/photo-1570129477492-45c003edd2be',
                        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
                      ],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteDetailesContent(
                              categoryTitle: 'House',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FavoriteFolderCardWidget(
                      title: 'Apartment',
                      subtitle: '1 week ago',
                      images: const [
                        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00',
                        'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab',
                        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
                        'https://images.unsplash.com/photo-1460317442991-0ec209397118',
                      ],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteDetailesContent(
                              categoryTitle: 'Apartment',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
