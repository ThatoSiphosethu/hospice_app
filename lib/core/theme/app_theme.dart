import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,

      // App background
      scaffoldBackgroundColor: Colors.grey[100],

      // ⭐ Bottom Nav Styling
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0D47A1), // Deep medical blue
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
