import 'package:flutter/material.dart';

class LocationHeaderWidget extends StatelessWidget {
  const LocationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // أيقونة الموقع
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7F6),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on_outlined, color: Color(0xFF00B4D8), size: 22),
        ),
        const SizedBox(width: 12),
        // نص الموقع
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Location',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 2),
            Text(
              'Los Angeles, California',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        const Spacer(),
        // أيقونة التنبيهات مع النقطة الحمراء
        _buildNotificationIcon(Icons.notifications_none_rounded, hasBadge: true),
        const SizedBox(width: 10),
        // أيقونة الدردشة مع النقطة الحمراء
        _buildNotificationIcon(Icons.chat_bubble_outline_rounded, hasBadge: true),
      ],
    );
  }

  Widget _buildNotificationIcon(IconData icon, {bool hasBadge = false}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
        if (hasBadge)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}