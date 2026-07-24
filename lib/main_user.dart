import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/bloc%20observe/bloc_service.dart';
import 'package:real_state/core/di.dart';
import 'app/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initAppModule();
  runApp(const AppUser());
}
