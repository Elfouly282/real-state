// ──────────────────────────────────────────────────────────────────────────────
// Entry points:
//
//  User App  (mobile):
//    flutter run -t lib/main_user.dart --flavor user
//
//  Admin Dashboard (web):
//    flutter run -t lib/main_admin.dart --flavor admin -d chrome
//
// Run flavorizr to generate platform configs:
//    dart run flutter_flavorizr
// ──────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
}
