import 'package:flutter/material.dart';

class PropertyCardWidget extends StatelessWidget {
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

  const PropertyCardWidget({
    super.key,
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
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. صورة العقار مع زوايا منحنية
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.apartment, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. العنوان والأيقونة المفضلة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const Icon(Icons.star_outline_rounded, color: Colors.amber, size: 22),
                  ],
                ),
                const SizedBox(height: 8),

                // 3. الموقع والمجال (Distance)
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Color(0xFF00B4D8), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.near_me_outlined, color: Color(0xFF00B4D8), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 4. تفاصيل الحجز (التاريخ، الغرفة، الوقت)
                Row(
                  children: [
                    _buildMetaDetail(Icons.calendar_today_outlined, checkInDate),
                    const SizedBox(width: 10),
                    _buildMetaDetail(Icons.person_outline, propertyType),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildMetaDetail(Icons.door_front_door_outlined, 'Room: $roomNo'),
                    const SizedBox(width: 10),
                    _buildMetaDetail(Icons.access_time_rounded, 'Time Booking: $bookingTime'),
                  ],
                ),
                const SizedBox(height: 12),

                // 5. السعر والتقييم (Price & Rating)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: '/month',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: Colors.grey.shade500),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}