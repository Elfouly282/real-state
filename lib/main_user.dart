import 'package:flutter/material.dart';
import 'package:real_state/core/di.dart';
import 'app/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  runApp(const AppUser());
}
