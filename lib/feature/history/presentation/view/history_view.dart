import 'package:flutter/material.dart';
import 'package:real_state/feature/history/presentation/widget/history_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/location_header_widget.dart';
import 'package:real_state/feature/history/presentation/widget/property_card_widget.dart';
import 'package:real_state/feature/history/presentation/widget/search_bar_widget.dart';
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 12),
              // 1. الهيدر (الموقع وأزرار الإشعارات)
              LocationHeaderWidget(),
              SizedBox(height: 16),
              
              // 2. شريط البحث وأيقونة الفلترة
              SearchBarWidget(),
              SizedBox(height: 20),
              
              // 3. شريط عنوان القائمة (History / Edit)
              HistoryHeaderWidget(),
              SizedBox(height: 16),
              
              // 4. بطاقات العقارات
              PropertyCardWidget(
                imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
                title: 'Modern Urban Apartment',
                location: 'Ocean Park, CA',
                distance: '160 miles',
                checkInDate: '8 - 20 Sept 2025',
                propertyType: 'Property...',
                roomNo: '64',
                bookingTime: '10:00 AM',
                price: '\$2,200',
                rating: '4.5',
              ),
              SizedBox(height: 16),
              PropertyCardWidget(
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}