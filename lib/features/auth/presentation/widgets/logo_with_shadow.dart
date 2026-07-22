import 'package:flutter/material.dart';

class LogoWithShadow extends StatelessWidget {
  final double size;

  const LogoWithShadow({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/png/logo2.png',
      width: size * 2.4,
      height: size * 0.9,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/png/logo.png',
        width: size * 2.4,
        height: size * 0.9,
        fit: BoxFit.contain,
      ),
    );
  }
}
