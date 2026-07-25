import 'package:flutter/material.dart';

class FavoritePropertyItemCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;
  final String location;
  final String distance;
  final String bedrooms;
  final String bathrooms;
  final bool hasKitchen;
  final String price;
  final String period;
  final String rating;

  const FavoritePropertyItemCard({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.title,
    required this.location,
    required this.distance,
    required this.bedrooms,
    required this.bathrooms,
    required this.hasKitchen,
    required this.price,
    required this.period,
    required this.rating,
  });

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
          // الصورة مع Tag الحجز
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.key_outlined, size: 14, color: Color(0xFF00B4D8)),
                      const SizedBox(width: 4),
                      Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان والنجمة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                  ],
                ),
                const SizedBox(height: 8),

                // الموقع والمسافة
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Color(0xFF00B4D8), size: 14),
                    const SizedBox(width: 4),
                    Text(location, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                    const SizedBox(width: 12),
                    const Icon(Icons.near_me_outlined, color: Color(0xFF00B4D8), size: 14),
                    const SizedBox(width: 4),
                    Text(distance, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 12),

                // الميزات (غرف نوم، حمام، مطبخ)
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    _buildFeature(Icons.bed_outlined, bedrooms),
                    _buildFeature(Icons.bathtub_outlined, bathrooms),
                    if (hasKitchen) _buildFeature(Icons.soup_kitchen_outlined, 'Open Kitchen'),
                  ],
                ),
                const SizedBox(height: 12),

                // السعر والتقييم
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
                            text: '/$period',
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
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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

  Widget _buildFeature(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}