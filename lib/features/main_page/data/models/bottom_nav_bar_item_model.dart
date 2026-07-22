import 'package:flutter/material.dart';

class BottomNavBarItemModel {
  final Widget screen;
  final IconData icon;
  final String label;

  BottomNavBarItemModel({
    required this.screen,
    required this.icon,
    required this.label,
  });
}
