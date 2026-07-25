import 'package:flutter/material.dart';

class HistoryHeaderWidget extends StatelessWidget {
  const HistoryHeaderWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
        ),
        const SizedBox(width: 12),
        const Text(
          'History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Edit',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF00B4D8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}