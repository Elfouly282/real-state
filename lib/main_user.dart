import 'package:flutter/material.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/core/security/security_helper.dart';
import 'package:real_state/feature/profile/profile_injector.dart';
import 'app/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  initProfileFeature();

  // 1. تمرير التوكن الصحيح
  await getIt<AuthStorage>().setToken('719|GMPAl7OzPeuZFrqTdsVTUmOZW35qkq5zooe26YWG6dddeca2');
  
  // 2. تمرير الـ ID الصحيح القادم من الاستجابة (217) 👈 هذا هو السر!
  await getIt<AuthStorage>().setUserId('217');
  runApp(const AppUser());
}