import 'package:flutter/material.dart';

class HistoryHeaderWidget extends StatelessWidget {
  final VoidCallback? onEditTap;
  final VoidCallback? onBackTap;
  final bool isEditing;

  const HistoryHeaderWidget({
    super.key,
    this.onEditTap,
    this.onBackTap,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBackTap ?? () => Navigator.maybePop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black87, size: 22),
        ),
        const SizedBox(width: 12),
        const Text(
          'History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onEditTap,
          child: Text(
            isEditing ? 'Done' : 'Edit',
            style: const TextStyle(
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