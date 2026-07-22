import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app_admin.dart';
import 'core/bloc_observer/bloc_service.dart';
import 'core/di.dart';
import 'features/agents/agents_di.dart';
import 'features/auth/auth_di.dart';
import 'features/categories/categories_di.dart';
import 'features/dashboard/dashboard_di.dart';
import 'features/orders/orders_di.dart';
import 'features/properties/properties_di.dart';
import 'features/users/users_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initAppModule();
  initAuthModule();
  initDashboardModule();
  initCategoriesModule();
  initPropertiesModule();
  initAgentsModule();
  initUsersModule();
  initOrdersModule();
  runApp(const AppAdmin());
}
