import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app_admin.dart';
import 'core/bloc observe/bloc_service.dart';
import 'core/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global BLoC observer
  Bloc.observer = MyBlocObserver();

  // Init core services (DioHelper, CacheHelper, AuthStorage, etc.)
  await initAppModule();

  // Init admin feature DI
  runApp(const AppAdmin());
}
