import 'package:evently_app/core/routes/app_routes.dart';
import 'package:evently_app/core/theme/app_theme_manager.dart';
import 'package:flutter/material.dart';

import 'core/routes/page_route_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
