import 'package:flutter/material.dart';

class AdminNavItem {
  final String label;
  final IconData icon;
  final String svgIcon;
  final Widget Function() pageBuilder;

  const AdminNavItem({
    required this.label,
    required this.icon,
    required this.svgIcon,
    required this.pageBuilder,
  });
}
