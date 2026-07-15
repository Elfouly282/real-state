import 'package:flutter/material.dart';
import 'package:real_state/features/onboarding/presentations/views/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnBoardingScreen());
  }
}
