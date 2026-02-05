import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const HospiceApp());
}

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
