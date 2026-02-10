/// Application entry point.
///
/// Boots the Hospice Clinical App, applying the global theme and route
/// configuration from `AppTheme` and `AppRouter`.
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const HospiceApp());
}

/// Root widget for the application.
///
/// Provides the top-level `MaterialApp` configuration including theme and
/// route table so other screens can navigate using named routes.
class HospiceApp extends StatelessWidget {
  const HospiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospice Clinical App',
      theme: AppTheme.lightTheme,
      routes: AppRouter.routes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
