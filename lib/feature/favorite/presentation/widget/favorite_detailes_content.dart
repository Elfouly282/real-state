import 'package:flutter/material.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_property_item_card.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class FavoriteDetailesContent extends StatelessWidget {
  final String categoryTitle;

  const FavoriteDetailesContent({super.key, required this.categoryTitle});

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
              const SearchBarWidget(),
              const SizedBox(height: 20),

              // شريط العودة مع اسم القائمة
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
                    'Your Favorite',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // عناصر قائمة العناصر المفضلة
              const FavoritePropertyItemCard(
                imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
                tag: 'For Rent',
                title: 'Modern Urban Apartment',
                location: 'Ocean Park, CA',
                distance: '160 miles',
                bedrooms: '3 Bedrooms',
                bathrooms: '1 Bathroom',
                hasKitchen: true,
                price: '\$2,200',
                period: 'month',
                rating: '4.5',
              ),
              const SizedBox(height: 16),
              const FavoritePropertyItemCard(
                imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
                tag: 'For Rent',
                title: 'Mid-Century Modern Home',
                location: 'Beverly Hills, CA',
                distance: '120 miles',
                bedrooms: '4 Bedrooms',
                bathrooms: '2 Bathrooms',
                hasKitchen: true,
                price: '\$3,800',
                period: 'month',
                rating: '4.8',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}