/// Global theme definitions for the app.
///
/// Centralizes `ThemeData` instances so the rest of the app can reuse
/// a consistent set of colors and styles.
import 'package:flutter/material.dart';

class AppTheme {
  /// Light theme used across the app.
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[100],
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
    );
  }
}
