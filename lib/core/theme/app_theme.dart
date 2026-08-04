import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF2563EB), // Blue-600
      secondary: Color(0xFF10B981), // Emerald-500
      surface: Color(0xFFF8FAFC), // Slate-50
      background: Colors.white,
      error: Color(0xFFEF4444), // Red-500
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black87,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF2563EB),
      unselectedItemColor: Color(0xFF6B7280),
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF60A5FA), // Blue-400
      secondary: Color(0xFF34D399), // Emerald-400
      surface: Color(0xFF1F2937), // Gray-800
      background: Color(0xFF111827), // Gray-900
      error: Color(0xFFF87171), // Red-400
    ),
    scaffoldBackgroundColor: Color(0xFF111827), // Gray-900
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1F2937), // Gray-800
      selectedItemColor: Color(0xFF60A5FA),
      unselectedItemColor: Color(0xFF9CA3AF),
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardTheme(
      color: Color(0xFF1F2937), // Gray-800
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}