import 'package:flutter/material.dart';

import '../../utils/app_fonts.dart';

/// Renders a pill-shaped coloured badge (e.g. roles, statuses).
class TableBadgeCell extends StatelessWidget {
  final String label;
  final Color color;

  const TableBadgeCell({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.30), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppFonts.labelSmall,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: AppFonts.questFont,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
