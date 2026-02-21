import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,

      // App background
      scaffoldBackgroundColor: Colors.lightBlueAccent[100],

      // Card styling
      cardTheme: CardThemeData(
        color: Colors.grey[50],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      // Bottom Nav Styling
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
