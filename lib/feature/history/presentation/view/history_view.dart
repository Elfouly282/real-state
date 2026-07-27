import 'package:flutter/material.dart';
import 'package:real_state/feature/history/presentation/widget/history_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/property_card_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';

class HistoryItemModel {
  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final String distance;
  final String checkInDate;
  final String propertyType;
  final String roomNo;
  final String bookingTime;
  final String price;
  final String rating;
  bool isFavorite;

  HistoryItemModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.distance,
    required this.checkInDate,
    required this.propertyType,
    required this.roomNo,
    required this.bookingTime,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isEditing = false;

  // قائمة عناوين البحث السابقة
  final List<String> _recentSearches = [
    'Modern Urban Apartment',
    'Royal Villa Resort',
    'Ocean Park',
    'Beverly Hills',
  ];

  // قائمة بطاقات السجل
  final List<HistoryItemModel> _historyItems = [
    HistoryItemModel(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      title: 'Modern Urban Apartment',
      location: 'Ocean Park, CA',
      distance: '160 miles',
      checkInDate: '8 - 20 Sept 2025',
      propertyType: 'Apartment',
      roomNo: '64',
      bookingTime: '10:00 AM',
      price: '\$2,200',
      rating: '4.5',
      isFavorite: true,
    ),
    HistoryItemModel(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
      title: 'Royal Villa Resort',
      location: 'Beverly Hills, CA',
      distance: '120 miles',
      checkInDate: '22 - 28 Oct 2025',
      propertyType: 'Villa',
      roomNo: '12',
      bookingTime: '02:30 PM',
      price: '\$4,500',
      rating: '4.9',
      isFavorite: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeSearchQuery(String query) {
    setState(() {
      _recentSearches.remove(query);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "$query" from search titles'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteHistoryItem(int index) {
    final item = _historyItems[index];
    setState(() {
      _historyItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${item.title}" from history'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite(HistoryItemModel item) {
    setState(() {
      item.isFavorite = !item.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.isFavorite
              ? 'Added "${item.title}" to favorites'
              : 'Removed "${item.title}" from favorites',
        ),
        backgroundColor: item.isFavorite ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.trim().toLowerCase();
    final filteredItems = query.isEmpty
        ? _historyItems
        : _historyItems.where((item) {
            return item.title.toLowerCase().contains(query) ||
                item.location.toLowerCase().contains(query);
          }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // 1. Location Header
              const LocationHeaderWidget(),
              const SizedBox(height: 16),

              // 2. Search Bar
              SearchBarWidget(
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    _searchQuery = text;
                  });
                },
              ),
              const SizedBox(height: 20),

              // 3. Recent Searches
              if (_recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Searched Titles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (_isEditing)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _recentSearches.clear();
                          });
                        },
                        child: const Text(
                          'Clear All',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _recentSearches.map((searchTitle) {
                    return Chip(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        searchTitle,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      deleteIcon: const Icon(Icons.cancel, size: 18, color: Colors.grey),
                      onDeleted: () => _removeSearchQuery(searchTitle),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],

              // 4. History Header Widget
              HistoryHeaderWidget(
                isEditing: _isEditing,
                onEditTap: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
              const SizedBox(height: 16),

              // 5. Property cards in history
              if (filteredItems.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'No items in history currently',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredItems.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return PropertyCardWidget(
                      imageUrl: item.imageUrl,
                      title: item.title,
                      location: item.location,
                      distance: item.distance,
                      checkInDate: item.checkInDate,
                      propertyType: item.propertyType,
                      roomNo: item.roomNo,
                      bookingTime: item.bookingTime,
                      price: item.price,
                      rating: item.rating,
                      isFavorite: item.isFavorite,
                      onFavoriteToggle: () => _toggleFavorite(item),
                      onDelete: _isEditing ? () => _deleteHistoryItem(index) : null,
                    );
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