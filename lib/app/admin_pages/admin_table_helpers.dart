import 'package:flutter/material.dart';
import '../../core/constant/admin_table_card.dart';

class AdminTableW {
  static Widget cell(String text, {bool bold = false}) =>
      bold ? TableBoldCell(text) : TableMutedCell(text);

  static Widget badge(String label, Color color) =>
      TableBadgeCell(label: label, color: color);
}
